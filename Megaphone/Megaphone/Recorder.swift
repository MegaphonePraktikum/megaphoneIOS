

import Foundation
import AVFoundation

class Recorder : AVAudioRecorder {
    
    let recordSettings:[NSObject: AnyObject] = [
        AVFormatIDKey: kAudioFormatMPEG4AAC,
        AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
        AVEncoderBitRateKey : 32000,
        AVNumberOfChannelsKey: 1,
        AVSampleRateKey : 22050.0
    ]
    
    init(d : AVAudioRecorderDelegate) {
        let currentFileName = "recording.m4a"
        println(currentFileName)
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir: AnyObject = dirPaths[0]
        let soundFilePath : NSString? = docsDir.stringByAppendingPathComponent(currentFileName)
        let soundFileURL : NSURL? = NSURL(fileURLWithPath: soundFilePath! as String)
        let filemanager = NSFileManager.defaultManager()
        

        var error: NSError?
        super.init(URL: soundFileURL!, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            delegate = d
            meteringEnabled = true
            prepareToRecord() // creates/overwrites the file at soundFileURL
        }
        
    }
    
    init(setup:Bool, del : AVAudioRecorderDelegate) {
        super.init()
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    Recorder.setSessionPlayAndRecord()
                    if setup {
                        self.init(d:del )
                    }
                    self.record()
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }
    
    static func setSessionPlayback() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayback, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    static func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    static func setAudioSessionInActive() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setActive(false, error: &error) {
            println("could not make session inactive")
            if let e = error {
                println(e.localizedDescription)
                return
            }
        }
    }
}