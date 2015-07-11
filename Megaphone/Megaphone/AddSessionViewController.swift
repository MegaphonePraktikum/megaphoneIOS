

import Foundation
import UIKit

class AddSessionViewController : UIViewController {
    
    let megaphoneService = AppDelegate.megaphoneService

    
    @IBAction func startBrowser(sender: UIButton) {
        NSLog("%@", "sessionNameLabel \(sessionNameLabel.text)")
        AppDelegate.megaphoneService.startBrowser(sessionNameLabel.text)
    }
    
    @IBOutlet weak var sessionNameLabel: UITextField!
}
