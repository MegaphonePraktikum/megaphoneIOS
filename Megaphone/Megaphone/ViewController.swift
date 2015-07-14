


import UIKit
import AVFoundation

class ViewController: UIViewController {

    //let megaphoneService = Manager()
    let megaphoneService = AppDelegate.megaphoneService

    var fileplayer = AVAudioPlayer()
        
    var recorder: AVAudioRecorder!
    
    var player : AVAudioPlayer!

    @IBOutlet var recButton: MegaphoneButton!
    
    @IBOutlet var instructionLabel: UILabel!
    
    @IBOutlet var countLabel: UILabel!
    
    var bgImage : UIView?

    @IBOutlet var bgV: UIImageView!
    
    @IBOutlet var sessionNameLabel: UILabel!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    var recTimer : NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        megaphoneService.delegate = self
        
        sessionNameLabel.text = megaphoneService.getSessionName() as String
        
        Recorder.setSessionPlayback()
        askForNotifications()
        
        recButton.addTarget(self, action: "startRecord:", forControlEvents: UIControlEvents.TouchDown)
        
        recButton.addTarget(self, action: "stopRecord:", forControlEvents: UIControlEvents.TouchUpInside|UIControlEvents.TouchUpOutside)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;

    }
    
    override func viewWillDisappear(animated: Bool) {
        //navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func back(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
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
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }
    
    func startRecord(sender: MegaphoneButton) {
        sender.isActive = true
        instructionLabel.text = "Record your message"
        
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            println("recording. recorder nil")
            recorder = Recorder(setup: true, del: self)
            return
        }
        
        if recorder != nil && recorder.recording {
            println("pausing")
            recorder.pause()
            
        } else {
            println("recording")
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
        
        Recorder.setAudioSessionInActive()
        recorder = nil
        

    }
    
    func stopRecord(sender: MegaphoneButton) {
        sender.isActive = false
        instructionLabel.text = "Hold down to record"
        
        recorder?.stop()
        player?.stop()
        
        Recorder.setAudioSessionInActive()
        megaphoneService.sendFile(soundFileURL: recorder.url!)

        recorder = nil
        


    }
    
}