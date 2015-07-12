


import Foundation
import MultipeerConnectivity

protocol ManagerDelegate {
    func playFile(manager : Manager, data: NSData, delayMS : Double)
    func countChanged(manager : Manager, count: Int)
    func lostConnection()
}

protocol SessionDelegate {
    func addSession(sessionName : NSString)
}

class Manager : NSObject {
    
    private let maxPeers : Int = 3
    private let maxLevel : Int = 3
    
    private let ServiceType = "megaphone"
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    private let pingData : NSMutableDictionary
    private let peers : NSMutableDictionary

    private var pingTimer : NSTimer? = nil
    private var soundFile : NSData?
    private var parentPeer = MCPeerID()
    private var maxPing : Double
    private var isSender : Bool
    private var sessionName: String = ""
    
    private var level : Int = 0
    
    var delegate : ManagerDelegate?
    var delegateSession : SessionDelegate?
    
    override init() {
        NSLog("%@", "Manager init()")

        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ServiceType)

        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ServiceType)
        
        self.pingData = NSMutableDictionary()
        self.peers = NSMutableDictionary()
        self.soundFile = NSData()
        
        self.maxPing = 0.0
        
        self.isSender = false
        
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
        for p in peers {
                NSLog("%@", "removeObject: \(p.key)")
                let s = p.value["session"] as! MCSession
                s.disconnect()
        }
        peers.removeAllObjects()
        NSLog("%@", "deinit");
    }
    
    lazy var session: MCSession = {
        NSLog("%@", "session \(self.myPeerId)");
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        session?.delegate = self
        return session
    }()
    
    lazy var parentSession: MCSession = {
        NSLog("%@", "parentSession \(self.myPeerId)");
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        session?.delegate = self
        return session
    }()
    
    func startBrowser(sessionNameLabel : String){
        self.sessionName = sessionNameLabel
        self.isSender = true
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
        for s in peers {
            (s.value["session"] as! MCSession).disconnect()
        }
        peers.removeAllObjects()
    }
    
    func setupAudioPlayerWithFile(soundFileURL : NSURL) -> NSData {
        NSLog("%@", "Path: \(soundFileURL)");
        
        var audioData: NSData? = NSData(contentsOfURL: soundFileURL)
        return audioData!;
        
    }
    
    func setupAudioPlayerWithFile(file : String, type : String) -> NSData {
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        NSLog("%@", "Path: \(file)");
        
        var audioData: NSData? = NSData(contentsOfURL: url!)
        return audioData!;
    }
    
    
    func sendPlaySavedFile(tag : String, maxPing : Double? = nil) {
        NSLog("%@", "sendPlaySavedFile: \(tag) ")
        
        if session.connectedPeers.count > 0 {
            var message : Message
            if let max = maxPing {
                message = Message(type: tag, data : NSKeyedArchiver.archivedDataWithRootObject(pingData), maxPing : maxPing!)
            }
            else {
                message = Message(type: tag, data : NSKeyedArchiver.archivedDataWithRootObject(pingData), maxPing : self.maxPing)
            }
            var error : NSError?
            if self.session.sendData( message.toNSData(), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
            }else{
                NSLog("%@", "\(error)")
            }
        }
        
    }
    
    func sendFile(soundFileURL : NSURL? = nil) {
        if session.connectedPeers.count > 0 {
            var message : Message
            if let file = soundFileURL {
                NSLog("%@", "sendFile: \(soundFileURL)")
                message = Message(type: "FILE", data: setupAudioPlayerWithFile(file))
            }
            else {
                NSLog("%@", "sendFile: test.mp3")
                message = Message(type: "FILE", data: setupAudioPlayerWithFile("test", type:"mp3"))
            }
            var error : NSError?
            if !self.session.sendData( message.toNSData(), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "\(error)")
            }
        }

    }
    
    func relayMessageOrSendReceive(message : Message) {
        NSLog("%@", "tryRelayMessage: \(message)")
        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if !self.session.sendData( message.toNSData(), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "\(error)")
            }
        }else{
            sendReceive()
        }
        
    }
    
    func sendPing(peerID : MCPeerID) {
        NSLog("%@", "trySendPingTo: \(peerID)")
        
        let message : Message = Message(type: "PING")

        if session.connectedPeers.count > 0 {
            var error : NSError?
            if self.session.sendData( message.toNSData(), toPeers: [peerID], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentPingTo: \(peerID)")
                var peerData = pingData[peerID] as! NSMutableDictionary;
                peerData["pingSent"] = NSDate.timeIntervalSinceReferenceDate();
            }else{
                NSLog("%@", "\(error)")
            }
        }
        
    }
    
    func sendCount(){
        NSLog("%@", "trySendCountTo: \(parentPeer)")
        let message : Message = Message(type: "Count")
        message.count = calcCount()
        if parentSession.connectedPeers.count > 0 {
            var error : NSError?
            if self.parentSession.sendData( message.toNSData(), toPeers: [parentPeer], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentCountTo: \(parentPeer)")
            }else{
                NSLog("%@", "\(error)")
            }
        }
    }
    
    func calcCount() -> Int{
        var childCount : Int = 0;
        for item in session.connectedPeers{
            if let count = pingData[item as! MCPeerID] as? NSMutableDictionary{
                if let lat = count["childCount"] {
                    childCount += Int(lat.integerValue)
                }
            }
        }
        childCount += session.connectedPeers.count
        NSLog("%@", "calculatedCount: \(childCount)")

        return childCount
    }
    
    func sendPing() {
        
        for peerID : MCPeerID in session.connectedPeers as! [MCPeerID] {
            NSLog("%@", "trySendPingTo: \(peerID)")
            
            let message : Message = Message(type: "PING")
            
            if session.connectedPeers.count > 0 {
                var error : NSError?
                if self.session.sendData( message.toNSData(), toPeers: [peerID], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                    NSLog("%@", "sentPingTo: \(peerID)")
                    var peerData = pingData[peerID] as! NSMutableDictionary;
                    peerData["pingSent"] = NSDate.timeIntervalSinceReferenceDate();
                }else{
                    NSLog("%@", "\(error)")
                }
            }
        }
    }
    
    func sendPong(peerID : MCPeerID, session: MCSession) {
        NSLog("%@", "trySendPongTo: \(peerID)")
        
        let message : Message = Message(type: "PONG")
        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if session.sendData( message.toNSData(), toPeers: [peerID], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentPongTo: \(peerID)")
            }else{
                NSLog("%@", "\(error)")
            }
        }
        
    }
    
    func sendReceive() {
        NSLog("%@", "trySendReceiveTo: \(parentPeer)")
        
        let message : Message = Message(type: "RECEIVE")
        message.maxPing = self.maxPing
        NSLog("%@", "sendReceiveMaxPing: \(maxPing) \(message.maxPing)")
        
        if parentSession.connectedPeers.count > 0 {
            var error : NSError?
            if self.parentSession.sendData( message.toNSData(), toPeers: [parentPeer], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentReceiveTo: \(parentPeer)")
            }else{
                NSLog("%@", "\(error)")
            }
        }
        
    }
    
    func sendPlay(maxPing : Double) {
        NSLog("%@", "trySendPlayTo: \(session.connectedPeers)")
        
        if session.connectedPeers.count > 0 {
            let message : Message = Message(type: "PLAY", data: NSKeyedArchiver.archivedDataWithRootObject(pingData), maxPing: maxPing)
            
            var error : NSError?
            if self.session.sendData( message.toNSData(), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentPlayTo: \(session.connectedPeers)")
            }else{
                NSLog("%@", "\(error)")
            }
        }
        setReceiveFalse()
    }
    
    func getMaxPing(dict : NSMutableDictionary) -> Double{
        var maxPing = 0.0;
        for peer in dict{
            var peerDict = peer.value as! NSMutableDictionary
            var currentPing = peerDict["latency"] as! Double
            if(maxPing < currentPing){
                maxPing = currentPing
            }
        }
        return maxPing
    }
    
    func setReceiveFalse(){
        for peer in pingData{
            var peerDict = peer.value as! NSMutableDictionary
            peerDict["received"] = false
        }
    }

    func didEveryoneReceive() ->Bool{
        for peer in pingData{
            var peerDict = peer.value as! NSMutableDictionary
            if let result = peerDict["received"] as? Bool {
                if(!result){
                    return false
                }
            }
            else {
                return false
            }
            /*var result = peerDict["received"] as? Bool
            if ((result != nil && !result) != nil){
                return false;
            }*/
        }
        return true;
    }
    
    func acceptSessionInvite(sessionName : NSString) {
        NSLog("%@", "acceptSessionInvite stopAdvertising: \(sessionName) \(peers.count) ")
        self.serviceAdvertiser.stopAdvertisingPeer()
        for p in peers{
            println(p)

        }
        let data : NSMutableDictionary = peers[sessionName] as! NSMutableDictionary
        self.sessionName = sessionName as String
        self.parentPeer = data["peerID"] as! MCPeerID
        self.parentSession = data["session"] as! MCSession
        self.level = data["level"] as! Int
        if(parentSession.connectedPeers.count >= maxPeers && level < maxLevel){
            serviceBrowser.startBrowsingForPeers()
        }else{
            serviceBrowser.stopBrowsingForPeers()
        }
        
        
        for p in peers {
            if !(p.key as! NSString == sessionName) {
                NSLog("%@", "removeObject: \(p.key)")
                let s = p.value["session"] as! MCSession
                s.disconnect()
                /*if !(s == parentSession) {
                    NSLog("%@", "removed Object and disconnect\(p.key)")
                    s.disconnect()
                }*/

            }
            else {
                NSLog("%@", "stayconnected: \(sessionName)")
            }
        }
        peers.removeAllObjects()

        /*let data: NSMutableDictionary = peers[sessionName] as! NSMutableDictionary
        self.parentPeer = data["peerID"] as! MCPeerID
        //let ih : ((Bool, MCSession!) -> Void)! = data["invitationHandler"] as! ((Bool, MCSession!) -> Void)!
        //ih!(true, self.parentSession)
        if(self.parentSession.connectedPeers.count > maxPeers){
            NSLog("%@", "tryDisconnectBecauseMax")
            self.parentSession.disconnect()
        }else{
            NSLog("%@", "stopAdvertising")
            self.serviceAdvertiser.stopAdvertisingPeer()
        }*/
    }
}

extension Manager : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)  sessionName \(NSString(data: context, encoding: NSUTF8StringEncoding))")
        let invite : Invite = Invite(data: context)
        
        if  let x = self.peers[invite.sessionName] {
            NSLog("%@", "session \(invite.sessionName) already exists");

        }
        else {
            let p : NSMutableDictionary = NSMutableDictionary()
            NSLog("%@", "session \(self.myPeerId)");
            let s = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
            s?.delegate = self
            p["peerID"] = peerID
            p["session"] = s
            p["level"] = invite.level
            println(p)
            peers[invite.sessionName] = p
            println(peers.count)
            println(peers[invite.sessionName])
            
            
            invitationHandler(true, s)
            
            
            self.delegateSession?.addSession(invite.sessionName)
        }


        
    }

}

extension Manager : MCNearbyServiceBrowserDelegate {
    
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        let invite : Invite = Invite(sessionName: self.sessionName, level: self.level+1)
        browser.invitePeer(peerID, toSession: self.session, withContext: invite.toNSData(), timeout: 10)
        
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension MCSessionState {
    
    func stringValue() -> String {
        switch(self) {
        case .NotConnected: return "NotConnected"
        case .Connecting: return "Connecting"
        case .Connected: return "Connected"
        default: return "Unknown"
        }
    }
    
}

extension Manager : MCSessionDelegate {
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        var str = state.stringValue();
        NSLog("%@", "peer \(peerID) didChangeState: \(str)")
        if(str=="Connected"){
            if(session == parentSession){
                NSLog("%@", "isParentSession")
                if(parentSession.connectedPeers.count >= maxPeers && level < maxLevel){
                    serviceBrowser.startBrowsingForPeers()
                }else{
                    serviceBrowser.stopBrowsingForPeers()
                }
            }else if(session == self.session) {
                NSLog("%@", "isChildSession")
                pingData[peerID] = NSMutableDictionary()
                sendPing(peerID)
                if let timer = pingTimer {
                    println("pingTimer already initialized")
                }
                else {
                    self.pingTimer = NSTimer(timeInterval: 100.0,
                        target: self,
                        selector: Selector("sendPing"),
                        userInfo: nil,
                        repeats: true)
                    NSRunLoop.mainRunLoop().addTimer(self.pingTimer!, forMode: NSRunLoopCommonModes)
                }

                if(session.connectedPeers.count >= maxPeers || level >= maxLevel){
                    serviceBrowser.stopBrowsingForPeers()
                }else{
                    serviceBrowser.startBrowsingForPeers()
                }
            }else {
                NSLog("%@", "isSessionFromSessionList")
                //serviceBrowser.startBrowsingForPeers()
            }
        }else if(str=="NotConnected"){
            if let timer = pingTimer {
                pingTimer!.invalidate()
            }
            if(parentSession.connectedPeers.count == 0 && session.connectedPeers.count == 0){
                serviceAdvertiser.startAdvertisingPeer()
            }
            if(peerID == parentPeer){
                NSLog("%@", "parentDisconnected")
                serviceBrowser.stopBrowsingForPeers()
                parentSession.disconnect()
                self.session.disconnect()
                self.delegate?.lostConnection()
            }else{
                if(session == self.session){
                    if(session.connectedPeers.count < maxPeers && parentSession.connectedPeers.count >= maxPeers && level < maxLevel){
                        serviceBrowser.startBrowsingForPeers()
                    }else{
                        serviceBrowser.stopBrowsingForPeers()
                    }
                    pingData.removeObjectForKey(peerID);
                    if(session.connectedPeers.count > 0 && didEveryoneReceive()){
                        if(isSender){
                            sendPlay(self.maxPing)
                        }else{
                            sendReceive()
                        }
                    }
                }
            }

        }
        if(isSender){
            self.delegate?.countChanged(self, count: calcCount())
        }else{
            sendCount()
        }
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        NSLog("%@", "didReceiveData: \(data.length) bytes")
        
        let message : Message = Message(data: data!)
        NSLog("%@", "didReceiveDataType: \(message.type)")
        
        switch message.type {
        case "PING":
            sendPong(peerID, session: session)
        case "PONG":
            var peerData = pingData[peerID]as! NSMutableDictionary;
            var pongReceived = NSDate.timeIntervalSinceReferenceDate();
            var pingSent = peerData["pingSent"]!.doubleValue as NSTimeInterval
            var latency = (pongReceived - pingSent)/2;
            peerData["latency"] = latency;
            peerData.removeObjectForKey("pingSent");
            
            NSLog("%@", "didCalculatePing: \(peerID) , \(latency * 1000.0)ms")
            var devicesAndPing : [String] = []
            for item in session.connectedPeers{
                if let ping = pingData[item as! MCPeerID] as? NSMutableDictionary{
                    if let lat = ping["latency"] {
                        var latency = Int(lat.doubleValue * 1000.0);
                        devicesAndPing.append("\(item.displayName) \(latency)ms")
                    }
                }else{
                    devicesAndPing.append(item.displayName)
                }
            }
            NSLog("%@", "changePing")
            
        case "FILE":
            soundFile = message.data!
            relayMessageOrSendReceive(message)
        case "RECEIVE":
            NSLog("%@", "receiveFile: \(peerID)")
            var peerData = pingData[peerID] as! NSMutableDictionary;
            peerData["latency"] = peerData["latency"]!.doubleValue + message.maxPing
            peerData["received"] = true;
            self.maxPing = getMaxPing(pingData)
            if(didEveryoneReceive()){
                if(self.isSender){
                    sendPlay(self.maxPing)
                }else{
                    sendReceive()
                }
            }
        case "PLAY":
            var delayPing = message.maxPing
            var peerDict = NSKeyedUnarchiver.unarchiveObjectWithData(message.data!) as! NSMutableDictionary
            println("peerDict \(peerDict)")
            var peerData = peerDict[myPeerId] as! NSMutableDictionary
            println("peerData \(peerData)")
            var myPing : Double = peerData["latency"] as! Double - self.maxPing
            println("myPing \(myPing)")
            if let sound = soundFile {
                self.delegate?.playFile(self, data: sound, delayMS: delayPing!-myPing)
                sendPlay(delayPing!-myPing)
            }
        case "111", "222", "333" :
            var delayPing = message.maxPing
            var peerDict = NSKeyedUnarchiver.unarchiveObjectWithData(message.data!) as! NSMutableDictionary
            println("peerDict \(peerDict)")
            var peerData = peerDict[myPeerId] as! NSMutableDictionary
            println("peerData \(peerData)")
            var myPing : Double = peerData["latency"] as! Double - self.maxPing
            println("myPing \(myPing)")
            let sound : NSData = setupAudioPlayerWithFile(message.type, type:"wav")
            self.delegate?.playFile(self, data: sound, delayMS: delayPing!-myPing)
            sendPlaySavedFile(message.type, maxPing: delayPing!-myPing)
        case "Count":
            var peerData = pingData[peerID]as! NSMutableDictionary;
            peerData["count"] = message.count;
            if(isSender){
                self.delegate?.countChanged(self, count: calcCount())
            }else{
                sendCount()
            }
        default:
            //Errormessage
            NSLog("%@", "Error in didReceiveData")
        }

    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(session: MCSession!, didReceiveCertificate certificate: [AnyObject]!, romPeer peerID: MCPeerID!, certificateHandler certificateHandler: ((Bool) -> Void)!) {
        certificateHandler(true)
    }
    
}
