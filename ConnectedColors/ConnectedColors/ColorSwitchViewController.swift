//
//  ViewController.swift
//  ConnectedColors
//
//  Created by Ralf Ebert on 28/04/15.
//  Copyright (c) 2015 Ralf Ebert. All rights reserved.
//

import UIKit
import AVFoundation

class ColorSwitchViewController: UIViewController {

    
    var documentsPath = NSHomeDirectory() + "/Documents/"

    let colorService = ColorServiceManager()
    var buttonBeep = AVAudioPlayer()
    var test = AVAudioPlayer()
    
    var recordSettings = [
        AVFormatIDKey: kAudioFormatMPEG4AAC,
        AVEncoderAudioQualityKey : AVAudioQuality.Low.rawValue,
        AVEncoderBitRateKey : 4800,
        AVNumberOfChannelsKey: 1,
        AVSampleRateKey : 22100.0
    ]
    
    var recorder: AVAudioRecorder!
    
    var player:AVAudioPlayer!
    
    var soundFileURL:NSURL?
    
    var soundFilePath:NSString?
    
    @IBOutlet var recordButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var statusLabel: UILabel!

    @IBOutlet var recButton: StarButton!
    
    @IBOutlet var bgView: UIImageView!
    
    @IBOutlet var connectionsLabel: UILabel!
    
    var bgImage : UIView?

    @IBOutlet var bgV: UIImageView!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
        
        stopButton.enabled = false
        playButton.enabled = false
        setSessionPlayback()
        askForNotifications()
        
        recButton.addTarget(self, action: "startRecord:", forControlEvents: UIControlEvents.TouchDown)
        
        recButton.addTarget(self, action: "stopRecord:", forControlEvents: UIControlEvents.TouchUpInside|UIControlEvents.TouchUpOutside)

    

        var image : UIImage = UIImage(named:"bg3.jpg")!
        
        bgV = UIImageView(image: image)
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.bounds.height, width: screenSize.width, height: 225)
        bgImage?.alpha = 0.8
        view.insertSubview(bgImage!, atIndex: 0)

        //buttonBeep = self.setupAudioPlayerWithFile("parkuhr", type:"mp3")
    }

    @IBAction func redTapped(sender: UIButton) {
        self.changeColor(UIColor.redColor())
        colorService.sendColor("red")
    }
    
    @IBAction func yellowTapped(sender: UIButton) {
        self.changeColor(UIColor.yellowColor())
        colorService.sendColor("yellow")
    }
    
    
    
    @IBAction func record(sender: UIButton) {
        
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            println("recording. recorder nil")
            recordButton.setTitle("Pause", forState:.Normal)
            playButton.enabled = false
            stopButton.enabled = true
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.recording {
            println("pausing")
            recorder.pause()
            recordButton.setTitle("Continue", forState:.Normal)
            
        } else {
            println("recording")
            recordButton.setTitle("Pause", forState:.Normal)
            playButton.enabled = false
            stopButton.enabled = true
            //            recorder.record()
            recordWithPermission(false)
        }
    }
    
    @IBAction func stop(sender: UIButton) {
        println("stop")
        
        recorder?.stop()
        player?.stop()
        
        //meterTimer.invalidate()
        
        recordButton.setTitle("Record", forState:.Normal)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setActive(false, error: &error) {
            println("could not make session inactive")
            if let e = error {
                println(e.localizedDescription)
                return
            }
        }
        playButton.enabled = true
        stopButton.enabled = false
        recordButton.enabled = true
        recorder = nil
        
        colorService.sendFile(soundFileURL!)

    }
    
    @IBAction func play(sender: UIButton) {
        play()
    }
    
    func play() {
        
        println("playing")
        var error: NSError?
        
        if let r = recorder {
            self.player = AVAudioPlayer(contentsOfURL: r.url, error: &error)
            if self.player == nil {
                if let e = error {
                    println(e.localizedDescription)
                }
            }
        } else {
            self.player = AVAudioPlayer(contentsOfURL: soundFileURL!, error: &error)
            if player == nil {
                if let e = error {
                    println(e.localizedDescription)
                }
            }
        }
        
        stopButton.enabled = true
        
        player.delegate = self
        player.prepareToPlay()
        player.volume = 1.0
        player.play()
    }
    
    
    
    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording.m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath! as String)
        let filemanager = NSFileManager.defaultManager()
        if filemanager.fileExistsAtPath(soundFilePath! as String) {
            // probably won't happen. want to do something about it?
            println("sound exists")
        }
        
        var recordSettings:[NSObject: AnyObject] = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }

    func setSessionPlayback() {
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
    
    func setSessionPlayAndRecord() {
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
    
    func askForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"background:",
            name:UIApplicationWillResignActiveNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"foreground:",
            name:UIApplicationWillEnterForegroundNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"routeChange:",
            name:AVAudioSessionRouteChangeNotification,
            object:nil)
    }

    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
    
    
    /*func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        //var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        //var url = NSURL.fileURLWithPath(path!)
        
        //2
        //var error: NSError?
        
        //3
        //var audioPlayer:AVAudioPlayer?
        //audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        
        
        //var audioData = NSData.dataWithContentsOfMappedFile(path!);
        
        //NSLog("%@", "Blaa: \(audioData)");
        
        //var audioPlayer2:AVAudioPlayer?
        //audioPlayer2 = AVAudioPlayer(data: audioData as NSData, error: &error);

        
        //4
        //return audioPlayer2!
    }*/
    
    func background(notification:NSNotification) {
        println("background")
    }
    
    func foreground(notification:NSNotification) {
        println("foreground")
    }
    
    
    func routeChange(notification:NSNotification) {
        //      let userInfo:Dictionary<String,String!> = notification.userInfo as Dictionary<String,String!>
        //      let userInfo = notification.userInfo as Dictionary<String,[AnyObject]!>
        //  var reason = userInfo[AVAudioSessionRouteChangeReasonKey]
        
        // var userInfo: [NSObject : AnyObject]? { get }
        //let AVAudioSessionRouteChangeReasonKey: NSString!
        
        /*
        if let reason = notification.userInfo[AVAudioSessionRouteChangeReasonKey] as? NSNumber  {
        }
        
        if let info = notification.userInfo as? Dictionary<String,String> {
        
        
        if let rs = info["AVAudioSessionRouteChangeReasonKey"] {
        var reason =  rs.toInt()!
        
        if rs.integerValue == Int(AVAudioSessionRouteChangeReason.NewDeviceAvailable.toRaw()) {
        }
        
        switch reason  {
        case AVAudioSessionRouteChangeReason
        println("new device")
        }
        
        }
        }
        
        var description = userInfo[AVAudioSessionRouteChangePreviousRouteKey]
        */
        /*
        //        var reason = info.valueForKey(AVAudioSessionRouteChangeReasonKey) as UInt
        //var reason = info.valueForKey(AVAudioSessionRouteChangeReasonKey) as AVAudioSessionRouteChangeReason.Raw
        //var description = info.valueForKey(AVAudioSessionRouteChangePreviousRouteKey) as String
        println(description)
        
        switch reason {
        case AVAudioSessionRouteChangeReason.NewDeviceAvailable.toRaw():
        println("new device")
        case AVAudioSessionRouteChangeReason.OldDeviceUnavailable.toRaw():
        println("old device unavail")
        //case AVAudioSessionRouteChangeReasonCategoryChange
        //case AVAudioSessionRouteChangeReasonOverride
        //case AVAudioSessionRouteChangeReasonWakeFromSleep
        //case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory
        
        default:
        println("something or other")
        }
        */
    }
    
}

extension ColorSwitchViewController : ColorServiceManagerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func pingChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
        NSLog("%@", "pingChanged")
    }
    
    func playFile(manager: ColorServiceManager, data: NSData) {

        var error: NSError?
        
        //NSLog("%@", "Blaa: \(data) Blaa")

        self.test = AVAudioPlayer(data: data as NSData, error: &error)
        self.test.play()
        //self.buttonBeep.play()


    }
    
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
                self.buttonBeep.play()
            case "yellow":
                self.changeColor(UIColor.yellowColor())
                self.buttonBeep.play()
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
            println("finished recording \(flag)")
            stopButton.enabled = false
            playButton.enabled = true
            recordButton.setTitle("Record", forState:.Normal)
            
            // iOS8 and later
            /*var alert = UIAlertController(title: "Recorder",
                message: "Finished Recording",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .Default, handler: {action in
                println("keep was tapped")
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: {action in
                println("delete was tapped")
                self.recorder.deleteRecording()
            }))
            self.presentViewController(alert, animated:true, completion:nil)*/
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }
    
    func startRecord(sender: StarButton) {
        sender.isFavorite = true
    }
    
    func stopRecord(sender: StarButton) {
        sender.isFavorite = false
    }
    
}