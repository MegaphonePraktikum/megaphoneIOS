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

    @IBOutlet weak var connectionsLabel: UILabel!
    
    let colorService = ColorServiceManager()
    var buttonBeep = AVAudioPlayer()
    var test = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
        //buttonBeep = self.setupAudioPlayerWithFile("parkuhr", type:"mp3")
    }

    @IBAction func redTapped(sender: AnyObject) {
        self.changeColor(UIColor.redColor())
        colorService.sendColor("red")
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.changeColor(UIColor.yellowColor())
        colorService.sendColor("yellow")
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
    
}

extension ColorSwitchViewController : ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func playFile(manager: ColorServiceManager, data: NSData) {

        var error: NSError?
        
        NSLog("%@", "Blaa: \(data) Blaa")

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
    
}