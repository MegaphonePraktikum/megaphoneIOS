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
    func playFile(manager : ColorServiceManager, data: NSData)

    
}

class ColorServiceManager : NSObject {
    
    private let ColorServiceType = "example-color"
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    private let pingData : NSMutableDictionary
    var delegate : ColorServiceManagerDelegate?
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)

        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)
        
        self.pingData = NSMutableDictionary()

        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
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
        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if !self.session.sendData(setup2("test", type:"mp3"), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "\(error)")
            }
        }

    }
    
    func sendFile(soundFileURL : NSURL) {
        NSLog("%@", "sendColor: \(soundFileURL)")
        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if !self.session.sendData( setupAudioPlayerWithFile(soundFileURL), toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "\(error)")
            }
        }
        
    }
    
    func sendPing(peerID : MCPeerID) {
        NSLog("%@", "trySendPingTo: \(peerID)")
        
        var data : NSData! = "ping".dataUsingEncoding(NSUTF8StringEncoding)
        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if self.session.sendData( data, toPeers: [peerID], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentPingTo: \(peerID)")
                var peerData = pingData[peerID] as NSMutableDictionary;
                peerData["pingSent"] = NSDate.timeIntervalSinceReferenceDate();
            }else{
                NSLog("%@", "\(error)")
            }
        }
        
    }
    
    func sendPong(peerID : MCPeerID) {
        NSLog("%@", "trySendPongTo: \(peerID)")
        
        var data : NSData! = "pong".dataUsingEncoding(NSUTF8StringEncoding)
        
        if session.connectedPeers.count > 0 {
            var error : NSError?
            if self.session.sendData( data, toPeers: [peerID], withMode: MCSessionSendDataMode.Reliable, error: &error) {
                NSLog("%@", "sentPongTo: \(peerID)")
            }else{
                NSLog("%@", "\(error)")
            }
        }
        
    }

    
}

extension ColorServiceManager : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
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
            pingData[peerID] = NSMutableDictionary();
            sendPing(peerID)
        }else if(str=="NotConnected"){
            pingData.removeObjectForKey(peerID);
        }
        self.delegate?.connectedDevicesChanged(self, connectedDevices: session.connectedPeers.map({$0.displayName}))
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        NSLog("%@", "didReceiveData: \(data.length) bytes")
        
        if(data.length < 8){
            let str = NSString(data: data, encoding: NSUTF8StringEncoding) as String
            if (str=="ping"){
                sendPong(peerID)
            }else if(str=="pong"){
                var peerData = pingData[peerID] as NSMutableDictionary;
                var pongReceived = NSDate.timeIntervalSinceReferenceDate();
                var pingSent = peerData["pingSent"]!.doubleValue as NSTimeInterval
                var latency = pongReceived - pingSent;
                peerData["latency"] = latency;
                peerData.removeObjectForKey("pingSent");
                
                NSLog("%@", "didCalculatePing: \(peerID) , \(latency * 1000.0)ms")
                var devicesAndPing : [String] = []
                for item in session.connectedPeers{
                    if let ping = pingData[item as MCPeerID] as? NSMutableDictionary{
                        var latency = Int(ping["latency"]!.doubleValue * 1000.0);
                        devicesAndPing.append("\(item.displayName) \(latency)ms")
                    }else{
                        devicesAndPing.append(item.displayName)
                    }
                }
                NSLog("%@", "changePing")
                self.delegate?.pingChanged(self, connectedDevices: devicesAndPing)
            }else{
                
            }
        }else{
            //self.delegate?.colorChanged(self, colorString: str)
            self.delegate?.playFile(self, data: data)
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
