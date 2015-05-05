//
//  SidePanelViewController.swift
//  Twitter
//
//  Created by John YS on 5/5/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func toggleSidePanel()
    func showProfile()
    func showTimeline()
    func showMentions()
}

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var delegate: SidePanelViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: MenuCell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        switch indexPath.row {
        case 0:
            cell.menuLabel.text = "Profile"
            break
        case 1:
            cell.menuLabel.text = "Timeline"
            break
        case 2:
            cell.menuLabel.text = "Mentions"
            break
        default:
            break
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            delegate?.showProfile()
            break
        case 1:
            delegate?.showTimeline()
            break
        case 2:
            delegate?.showMentions()
            break
        default:
            break
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
