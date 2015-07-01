
//
//  Message.swift
//  ConnectedColors
//
//  Created by admin on 29/06/15.
//  Copyright (c) 2015 Ralf Ebert. All rights reserved.
//

import Foundation


class Message : NSObject, NSCoding {
    
    var type: String! // PING | PONG | FILE
    var data: NSData? // Sound
    
    // MARK: NSCoding
    
    // required for NSCoding but never used
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.type = decoder.decodeObjectForKey("type") as String
        self.data = decoder.decodeObjectForKey("data") as NSData?
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.type, forKey: "type")
        coder.encodeObject(self.data, forKey: "data")
    }
    
    // init PING | PONG without data, FILE with data
    convenience init(type: String, data: NSData? = nil){
        self.init()
        self.type = type
        self.data = data
    }
    
    // init when received
    convenience init(data : NSData) {
        self.init()
        let m : Message = NSKeyedUnarchiver.unarchiveObjectWithData(data) as Message
        self.type = m.type
        self.data = m.data
    }
    
    //
    func toNSData() -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
}

