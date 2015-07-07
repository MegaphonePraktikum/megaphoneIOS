

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    var documentsPath = NSHomeDirectory() + "/Documents/"

    let megaphoneService = Manager()
    var buttonBeep = AVAudioPlayer()
    var fileplayer = AVAudioPlayer()
        
    var recorder: AVAudioRecorder!
    
    var player : AVAudioPlayer!
    
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
        megaphoneService.delegate = self
        
        stopButton.enabled = false
        playButton.enabled = false
        setSessionPlayback()
        askForNotifications()
        
        recButton.addTarget(self, action: "startRecord:", forControlEvents: UIControlEvents.TouchDown)
        
        recButton.addTarget(self, action: "stopRecord:", forControlEvents: UIControlEvents.TouchUpInside|UIControlEvents.TouchUpOutside)    

    }

    @IBAction func redTapped(sender: UIButton) {
        megaphoneService.sendFile()
    }
    
    
    @IBAction func startBrowser(sender: UIButton) {
        megaphoneService.startBrowser()
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
        
        megaphoneService.sendFile(soundFileURL: soundFileURL!)

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
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 32000,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey : 22050.0
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


    
    func background(notification:NSNotification) {
        println("background")
    }
    
    func foreground(notification:NSNotification) {
        println("foreground")
    }
    
    
}

extension ViewController : ManagerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    func connectedDevicesChanged(manager: Manager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func pingChanged(manager: Manager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
        NSLog("%@", "pingChanged")
    }
    
    func playFile(manager: Manager, data: NSData, delayMS : Double ) {
        NSLog("%@", "playWithDelay: \(delayMS)")
        var error: NSError?
    
        self.fileplayer = AVAudioPlayer(data: data as NSData, error: &error)
        self.fileplayer.playAtTime(self.fileplayer.deviceCurrentTime + delayMS)

    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
            println("finished recording \(flag)")
            stopButton.enabled = false
            playButton.enabled = true
            recordButton.setTitle("Record", forState:.Normal)
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