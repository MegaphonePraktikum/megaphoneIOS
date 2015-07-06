

import Foundation


class Message : NSObject, NSCoding {
    
    var type: String! // PING | PONG | FILE
    var maxPing: Double! //MaxPing
    var data: NSData? // Sound
    
    // MARK: NSCoding
    
    // required for NSCoding but never used
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.type = decoder.decodeObjectForKey("type") as! String
        self.data = decoder.decodeObjectForKey("data") as! NSData?
        self.maxPing = decoder.decodeObjectForKey("maxPing") as! Double
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.type, forKey: "type")
        coder.encodeObject(self.data, forKey: "data")
        coder.encodeObject(self.maxPing, forKey: "maxPing")
    }
    
    // init PING | PONG without data, FILE with data
    convenience init(type: String, data: NSData? = nil, maxPing: Double = 0){
        self.init()
        self.type = type
        self.data = data
        self.maxPing = maxPing
    }
    
    // init when received
    convenience init(data : NSData) {
        self.init()
        let m : Message = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Message
        self.type = m.type
        self.data = m.data
        self.maxPing = m.maxPing
    }
    
    //
    func toNSData() -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
}

