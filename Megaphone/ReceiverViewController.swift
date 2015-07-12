


import UIKit
import AVFoundation

class ReceiverViewController: UIViewController {
    
    //let megaphoneService = Manager()
    let megaphoneService = AppDelegate.megaphoneService
    
    var fileplayer = AVAudioPlayer()
    
    var recorder: AVAudioRecorder!
    
    var player : AVAudioPlayer!
    
    @IBOutlet var recordButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var recButton: MegaphoneButton!
    
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

extension ReceiverViewController : ManagerDelegate, AVAudioPlayerDelegate {
    
    func connectedDevicesChanged(manager: Manager, connectedDevices: [String]) {
    }
    
    func pingChanged(manager: Manager, connectedDevices: [String]) {
    }
    
    func playFile(manager: Manager, data: NSData, delayMS : Double ) {
        NSLog("%@", "playWithDelay: \(delayMS)")
        var error: NSError?
        
        self.fileplayer = AVAudioPlayer(data: data as NSData, error: &error)
        self.fileplayer.playAtTime(self.fileplayer.deviceCurrentTime + delayMS)
        
    }
    
    func countChanged(manager: Manager, count: Int) {
        
    }
    
    func lostConnection() {
        var alert = UIAlertController(title: "Alert", message: "Lost connection...", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            navigationController?.popViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }
    

    
}
