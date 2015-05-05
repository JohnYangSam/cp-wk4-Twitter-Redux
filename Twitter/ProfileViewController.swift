//
//  ProfileViewController.swift
//  Twitter
//
//  Created by John YS on 5/4/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    
    // Store user information through the segue
    var user:User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            var phc = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell", forIndexPath: indexPath) as! ProfileHeaderCell
            
            phc.profileViewImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
            
            //phc.numTweets.text =
            
        } else {
            var twc = tableView.dequeueReusableCellWithIdentifier("TweetViewCell", forIndexPath: indexPath) as! TweetViewCell
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // +1 because of the profile header cell
        return tweets.count + 1
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
