

import Foundation
import UIKit
import MultipeerConnectivity


class SessionsViewController : UITableViewController {
    
    var megaphoneService = AppDelegate.megaphoneService
    
    override func viewDidLoad() {
        megaphoneService.delegateSession = self
    }
    
    override func viewWillAppear(animated: Bool) {
        AppDelegate.megaphoneService = Manager()
        megaphoneService = AppDelegate.megaphoneService
    }
    
    var data : NSMutableArray = NSMutableArray()
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = data[indexPath.row] as! String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sessionName : NSString = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel!.text)!
        NSLog("%@", "didSelectRowAtIndexPath \(tableView.cellForRowAtIndexPath(indexPath)?.textLabel!.text)")
        
        megaphoneService.acceptSessionInvite(sessionName)
    }

    
}

extension SessionsViewController : SessionDelegate {
    func addSession(sessionName : NSString) {
        NSLog("%@", "sessionViewController addSession")
        data.addObject(sessionName)
        self.tableView.reloadData()

    }
    
    
}