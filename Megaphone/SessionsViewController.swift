

import Foundation
import UIKit
import MultipeerConnectivity


class SessionsViewController : UITableViewController {
    
    var first : Bool = true
    var megaphoneService = AppDelegate.megaphoneService
    var data : [String] = []
    var connections : NSMutableDictionary = NSMutableDictionary()

    
    override func viewDidLoad() {
        megaphoneService.delegateSession = self
        megaphoneService.delegateLostConnection = self
    }
    
    override func viewWillAppear(animated: Bool) {
        //data = NSMutableArray()
        data = []
        connections = NSMutableDictionary()
        NSLog("%@", "resetData: \(data.count)")
        self.tableView.reloadData()
        if(!first){
            megaphoneService.reset()
        }
        first = false;
    }
    
    
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

extension SessionsViewController : SessionDelegate, LostConnectionDelegate {
    
    func addSession(sessionName : NSString, peerID : MCPeerID) {
        NSLog("%@", "sessionViewController addSession")
        data.append(sessionName as String)
        connections[peerID] = sessionName as String
        //data.addObject(sessionName)
        self.tableView.reloadData()

    }
    
    func lostConnection(peerID : MCPeerID) {
        println("lostConnection")
        if let sessionName : String = connections[peerID] as? String {
            data = data.filter(){ $0 != sessionName }
            connections.removeObjectForKey(peerID)
            //myArrayOfStrings = myArrayOfStrings.filter() { $0 != "Hello" }
            self.tableView.reloadData()
        }
    }
}