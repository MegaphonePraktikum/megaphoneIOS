

import Foundation
import UIKit

class AddSessionViewController : UIViewController {
    
    let megaphoneService = AppDelegate.megaphoneService

    
    @IBAction func startBrowser(sender: UIButton) {
        NSLog("%@", "sessionNameLabel \(sessionNameLabel.text)")
        if(!sessionNameLabel.text.isEmpty){
            AppDelegate.megaphoneService.startBrowser(sessionNameLabel.text)
            self.performSegueWithIdentifier("AddSessionSegue", sender: self)
        }else{
            var device : UIDevice = UIDevice.currentDevice()
            var systemVersion : NSString = device.systemVersion
            var iosVerion : Float = systemVersion.floatValue
            if(iosVerion < 8.0) {
                let alert = UIAlertView()
                alert.title = "Invalid Input"
                alert.message = "The name can not be empty"
                alert.addButtonWithTitle("OK")
                alert.show()
            }else{
                var alert = UIAlertController(title: "Invalid Input", message: "The name can not be empty", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBOutlet weak var sessionNameLabel: UITextField!
}
