


import UIKit
import AVFoundation

class ViewController: UIViewController {

    //let megaphoneService = Manager()
    let megaphoneService = AppDelegate.megaphoneService

    var fileplayer = AVAudioPlayer()
        
    var recorder: AVAudioRecorder!
    
    var player : AVAudioPlayer!
    
    @IBOutlet var recordButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var statusLabel: UILabel!

    @IBOutlet var recButton: StarButton!
    
    @IBOutlet var bgView: UIImageView!
    
    @IBOutlet var connectionsLabel: UILabel!
    
    @IBOutlet var instructionLabel: UILabel!
    
    @IBOutlet var countLabel: UILabel!
    
    var bgImage : UIView?

    @IBOutlet var bgV: UIImageView!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    var recTimer : NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        megaphoneService.delegate = self
        
        stopButton.enabled = false
        playButton.enabled = false
        Recorder.setSessionPlayback()
        askForNotifications()
        
        recButton.addTarget(self, action: "startRecord:", forControlEvents: UIControlEvents.TouchDown)
        
        recButton.addTarget(self, action: "stopRecord:", forControlEvents: UIControlEvents.TouchUpInside|UIControlEvents.TouchUpOutside)    

    }

    @IBAction func redTapped(sender: UIButton) {
        megaphoneService.sendFile()
    }
    
    @IBAction func playFileTapped(sender: UIButton) {
        megaphoneService.sendPlaySavedFile(String(sender.tag))
    }
    
    @IBAction func startBrowser(sender: UIButton) {
        megaphoneService.startBrowser("ghfhf")
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
            recorder = Recorder(setup: true, del: self)
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
            recorder = Recorder(setup: false, del: self)
        }
    }
    
    @IBAction func stop(sender: UIButton) {
        println("stop")
        
        recorder?.stop()
        player?.stop()
        
        recordButton.setTitle("Record", forState:.Normal)
        Recorder.setAudioSessionInActive()
        playButton.enabled = true
        stopButton.enabled = false
        recordButton.enabled = true
        megaphoneService.sendFile(soundFileURL: recorder.url!)

        recorder = nil
        

    }
    
    @IBAction func play(sender: UIButton) {
        play()
    }
    
    func play() {
        
        instructionLabel.text = "Hold down to record"
        
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
            self.player = AVAudioPlayer(contentsOfURL: recorder.url!, error: &error)
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
    
    
    


    
    func askForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"background:",
            name:UIApplicationWillResignActiveNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"foreground:",
            name:UIApplicationWillEnterForegroundNotification,
            object:nil)
        
        /*NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"routeChange:",
            name:AVAudioSessionRouteChangeNotification,
            object:nil)*/
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
    
    func countChanged(manager: Manager, count: Int) {
        NSLog("%@", "trySetCounter: \(count)")
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.countLabel.text = "\(count)"
        }
        
    }
    
    func lostConnection() {
        var alert = UIAlertController(title: "Alert", message: "Lost connection...", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            navigationController?.popViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
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
        instructionLabel.text = "Record your message"
        
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            println("recording. recorder nil")
            recordButton.setTitle("Pause", forState:.Normal)
            playButton.enabled = false
            stopButton.enabled = true
            recorder = Recorder(setup: true, del: self)
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
            recorder = Recorder(setup: false, del: self)
        }
        
        recTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("stop"), userInfo: nil, repeats: true)
    }
    
    func stop(){

        println("Test");
        instructionLabel.text = "Message is pending..."
        
        recorder?.stop()
        player?.stop()
        
        recordButton.setTitle("Record", forState:.Normal)
        Recorder.setAudioSessionInActive()
        playButton.enabled = true
        stopButton.enabled = false
        recordButton.enabled = true
        recorder = nil
        

    }
    
    func stopRecord(sender: StarButton) {
        sender.isFavorite = false
        instructionLabel.text = "Message is pending..."
        
        recorder?.stop()
        player?.stop()
        
        recordButton.setTitle("Record", forState:.Normal)
        Recorder.setAudioSessionInActive()
        playButton.enabled = true
        stopButton.enabled = false
        recordButton.enabled = true
        megaphoneService.sendFile(soundFileURL: recorder.url!)

        recorder = nil
        


    }
    
}