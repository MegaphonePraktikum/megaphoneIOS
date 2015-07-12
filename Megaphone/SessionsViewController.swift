

import Foundation
import UIKit
import MultipeerConnectivity


class SessionsViewController : UITableViewController {
    
    var first : Bool = true
    var megaphoneService = AppDelegate.megaphoneService
    
    override func viewDidLoad() {
        megaphoneService.delegateSession = self
    }
    
    override func viewWillAppear(animated: Bool) {
        data = NSMutableArray()
        NSLog("%@", "resetData: \(data.count)")
        self.tableView.reloadData()
        if(!first){
            AppDelegate.megaphoneService = Manager()
        }
        first = false;
    }
    
    var data : NSMutableArray = NSMutableArray()
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("%@", "dataCount: \(data.count)")
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = data[indexPath.row] as! String
        NSLog("%@", "setCellLabel: \(data.count)")
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