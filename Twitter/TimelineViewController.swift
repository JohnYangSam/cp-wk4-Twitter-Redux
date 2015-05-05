//
//  TimelineViewController.swift
//  Twitter
//
//  Created by John YS on 4/27/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetViewCellDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Instance variables
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    var additionalText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add UIRefreshControl as a subview of the UITableView - using the lowest index so that it appears behind everything
        refreshControl = UIRefreshControl()
        // 'onRefresh' will be the function called
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        
        // UITableView automatic dimensions
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            
            if tweets != nil {
                self.tweets = tweets!
                self.tableView.reloadData()
            } else {
                // Handle the error here
            }
        })
        
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if tweets != nil {
                self.tweets = tweets!
                self.tableView.reloadData()
            } else {
                // Handle the error here
            }
            self.refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // SignOut/Logout Action
    @IBAction func onClickSignOut(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        User.currentUser?.logout()
    }
    
    @IBAction func onClickComposeTweet(sender: AnyObject) {
        self.performSegueWithIdentifier("composeSegue", sender: sender)
    }
    
    
    @IBAction func onProfileImageTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("profileSegue", sender: sender)
    }
    
    // TableView Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TweetViewCell = tableView.dequeueReusableCellWithIdentifier("TweetViewCell") as! TweetViewCell
        
        let tweet:Tweet = tweets[indexPath.row]
        println("tweet from hometimeline: \(tweet.tweetId)")
        
        cell.tweetIdLabel.text = tweet.tweetId!
        
        if let user:User = tweet.user {
            cell.profilePicture.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
            cell.nameLabel.text = user.name
            cell.screenNameLabel.text = user.screenname
        }
        
        if let text:String = tweet.text {
            cell.tweetTextLabel.text = text
        }
        
        if let createdAtDate:NSDate = tweet.createdAtDate {
            // Get the current date
            var time = String(format: "%.0f", round(createdAtDate.timeIntervalSinceNow / 60 * -1))
            cell.hoursLabel.text = time + "h"
            
        }
       
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    // TweetViewCell Delegation
    
    func retweetTweet(tweetId: String) {
        TwitterClient.sharedInstance.reTweetWithCompletion(tweetId, completion: { (error) -> () in
            if error != nil {
                var alert = UIAlertController(title: "Success", message: "Tweet retweeted!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                    nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    
    }
    
    func favoriteTweet(tweetId: String) {
        TwitterClient.sharedInstance.favoriteWithCompletion(tweetId, completion: { (error) -> () in
            if error != nil {
                var alert = UIAlertController(title: "Success", message: "Tweet favorited!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                    nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    
    }
    
    func replyToTweet(screenname: String) {
        additionalText = "@\(screenname) "
        self.performSegueWithIdentifier("composeSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // For segue into TweetDetailViewController
        if segue.identifier == "tweetDetailViewSegue" {
            var twc: TweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            
            let tweet: Tweet = tweets[indexPath.row]
            
            twc.profilePictureURL = tweet.user?.profileImageUrl
            twc.name = tweet.user?.name
            twc.screenName = tweet.user?.screenname
            twc.tweetText = tweet.text
            twc.dateText = tweet.createdAtString
            twc.numFavorites = tweet.favoriteCount
            twc.numRetweets = tweet.retweetCount
            twc.tweet = tweet
            
            println("seguing into detail tweet")
        }
        
        if segue.identifier == "composeSegue" {
            // Set up the additional text
            var twc: TweetViewController = segue.destinationViewController as! TweetViewController
            twc.startingText = additionalText
            additionalText = "" // reset the additional text
        }
        
        if segue.identifier == "profileSegue" {
            // Setup the incoming view controller
            var pvc: ProfileViewController = segue.destinationViewController as! ProfileViewController
            
            // Get the location of what was tapped
            var gesture = sender as! UITapGestureRecognizer
            var location = gesture.locationInView(tableView)
            var tappedIndexPath = tableView.indexPathForRowAtPoint(location)!
            
            // Set the user for the profile controller
            pvc.user = tweets[tappedIndexPath.row].user
            
            println("user being sent: \(pvc.user)")
            
        }
    }

}
