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
        self.tableView.reloadData()
        
        // UITableView automatic dimensions
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        var params:NSDictionary = NSDictionary(object: user.screenname!, forKey: "screen_name")
        
        TwitterClient.sharedInstance.userTimelineWithParams(params, completion: { (tweets, error) -> () in
            
            if tweets != nil {
                self.tweets = tweets!
                self.tableView.reloadData()
            } else {
                // Handle the error here
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            println("profile view header instantiated")
            var phc = tableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell", forIndexPath: indexPath) as! ProfileHeaderCell
            
            phc.profileViewImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
            
            phc.numTweets.text = user.numTweets
            phc.numFollowers.text = user.numFollowers
            phc.numFollowing.text = user.numFollowing
            
            cell = phc
            
        } else {
            var twc = tableView.dequeueReusableCellWithIdentifier("TweetViewCell", forIndexPath: indexPath) as! TweetViewCell
            
            var tweet = tweets[indexPath.row - 1] // because the first one is for the header
            
            twc.profilePicture.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
            twc.screenNameLabel.text = tweet.user?.screenname
            twc.nameLabel.text = tweet.user?.name
            var time = String(format: "%.0f", round(tweet.createdAtDate!.timeIntervalSinceNow / 60 * -1))
            twc.hoursLabel.text = time + "h"
            twc.tweetTextLabel.text = tweet.text
            
            cell = twc
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
