import Foundation


class Invite : NSObject, NSCoding {
    
    var sessionName: String!
    var level: Int!
    
    // MARK: NSCoding
    
    // required for NSCoding but never used
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.sessionName = decoder.decodeObjectForKey("sessionName") as! String
        self.level = decoder.decodeObjectForKey("level") as! Int
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.sessionName, forKey: "sessionName")
        coder.encodeObject(self.level, forKey: "level")
    }
    
    // init PING | PONG without data, FILE with data
    convenience init(sessionName: String, level: Int){
        self.init()
        self.sessionName = sessionName
        self.level = level
    }
    
    // init when received
    convenience init(data : NSData) {
        self.init()
        let m : Invite = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Invite
        self.sessionName = m.sessionName
        self.level = m.level
    }
    
    //
    func toNSData() -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
}

