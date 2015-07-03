//
//  ColorServiceManager.swift
//  ConnectedColors
//
//  Created by Ralf Ebert on 28/04/15.
//  Copyright (c) 2015 Ralf Ebert. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager : ColorServiceManager, connectedDevices: [String])
    func pingChanged(manager : ColorServiceManager, connectedDevices: [String])
    func colorChanged(manager : ColorServiceManager, colorString: String)
    func playFile(manager : ColorServiceManager, data: NSData, delayMS : Double)

    
}

class ColorServiceManager : NSObject {
    
    private let maxPeers : Int = 1
    
    private let ColorServiceType = "example-color"
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    private let pingData : NSMutableDictionary
    
    private var soundFile : NSData?
    private var parentPeer = MCPeerID()
    private var maxPing : Double
    private var isSender : Bool
    
    var delegate : ColorServiceManagerDelegate?
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)

        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)
        
        self.pingData = NSMutableDictionary()
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
    }
    
    lazy var session: MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        session?.delegate = self
        return session
    }()
    
    lazy var parentSession: MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        session?.delegate = self
        return session
    }()
    
    func startBrowser(){
        self.isSender = true
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func setupAudioPlayerWithFile(soundFileURL : NSURL) -> NSData {
        //var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        //var url = NSURL.fileURLWithPath(path!)
        
        NSLog("%@", "Path: \(soundFileURL)");
        
        var audioData: NSData? = NSData(contentsOfURL: soundFileURL)
        return audioData!;
        
    }
    
    func setup2(file : String, type : String) -> NSData {
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        NSLog("%@", "Path: \(file)");
        
        var audioData: NSData? = NSData(contentsOfURL: url!)
        return audioData!;
    }

    func sendColor(colorName : String) {
        NSLog("%@", "sendColor: \(colorName)")
        
        let message: Message = Message(type: "FILE", data: setup2("test", type:"mp3"))

        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if !self.session.sendData(message.toNSData(), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "\(error)")
            }
        }

    }
    
    func sendFile(soundFileURL : NSURL) {
        NSLog("%@", "sendColor: \(soundFileURL)")
        
        let message : Message = Message(type: "FILE", data: setupAudioPlayerWithFile(soundFileURL))
        
        if session.connectedPeers.count > 0 {
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
    
    func sendPong(peerID : MCPeerID) {
        NSLog("%@", "trySendPongTo: \(peerID)")
        
        let message : Message = Message(type: "PONG")
        
        if parentSession.connectedPeers.count > 0 {
            var error : NSError?
            if self.parentSession.sendData( message.toNSData(), toPeers: [peerID], withMode: MCSessionSendDataMode.Reliable, error: &error) {
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
    
}

extension ColorServiceManager : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        self.parentPeer = peerID
        invitationHandler(true, self.parentSession)
        if(self.parentSession.connectedPeers.count > maxPeers){
            self.parentSession.disconnect()
        }else{
            self.serviceAdvertiser.stopAdvertisingPeer()
        }
        
    }

}

extension ColorServiceManager : MCNearbyServiceBrowserDelegate {
    
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, toSession: self.session, withContext: nil, timeout: 10)
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

extension ColorServiceManager : MCSessionDelegate {
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        var str = state.stringValue();
        NSLog("%@", "peer \(peerID) didChangeState: \(str)")
        if(str=="Connected"){
            if(session == parentSession){
                if(parentSession.connectedPeers.count >= maxPeers){
                    serviceBrowser.startBrowsingForPeers()
                }else{
                    serviceBrowser.stopBrowsingForPeers()
                }
            }else{
                pingData[peerID] = NSMutableDictionary()
                sendPing(peerID)
                if(session.connectedPeers.count >= maxPeers){
                    serviceBrowser.stopBrowsingForPeers()
                }else{
                    serviceBrowser.startBrowsingForPeers()
                }
            }
            
            
        }else if(str=="NotConnected"){
            if(peerID == parentPeer){
                parentSession.disconnect()
                self.session.disconnect()
                serviceAdvertiser.startAdvertisingPeer()
            }else{
                if(session == self.session){
                    if(session.connectedPeers.count < maxPeers && parentSession.connectedPeers.count >= maxPeers){
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
        self.delegate?.connectedDevicesChanged(self, connectedDevices: session.connectedPeers.map({$0.displayName}))
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        NSLog("%@", "didReceiveData: \(data.length) bytes")
        
        let message : Message = Message(data: data!)
        NSLog("%@", "didReceiveDataType: \(message.type)")
        
        switch message.type {
        case "PING":
            sendPong(peerID)
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
            self.delegate?.pingChanged(self, connectedDevices: devicesAndPing)
            
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
    
}
