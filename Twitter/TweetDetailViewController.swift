//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by John YS on 4/28/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    // Outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    
    // Instance variables
    var additionalText: String = ""
    
    // From the segue
    var profilePictureURL: String? = ""
    var name: String? = ""
    var screenName: String? = ""
    var tweetText: String? = ""
    var dateText: String? = ""
    var numRetweets: String? = ""
    var numFavorites: String? = ""
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let pictureString: String = profilePictureURL  {
            profilePicture.setImageWithURL(NSURL(string: pictureString))
            
        }
        
        if let nameText: String = name {
            nameLabel.text = nameText
        }
        
        if let screenname: String = screenName {
            screenNameLabel.text = screenname
        }
        
        if let text: String = tweetText {
            self.tweetTextLabel.text = text
        }
        
        if let dateString: String = dateText {
            self.dateTextLabel.text = dateString
        }
        
       
        if let retweetCount: String = numRetweets {
            numRetweetsLabel.text = retweetCount
        }
        
        if let favoriteCount: String = numFavorites {
            numFavoritesLabel.text = favoriteCount
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button callbacks
    @IBAction func onReplyClick(sender: AnyObject) {
        additionalText = "@\(screenName!) "
        self.performSegueWithIdentifier("composeTweetFromDetailSegue", sender: self)
        
    }

    @IBAction func onReplyButtonClicked(sender: AnyObject) {
        additionalText = "@\(screenName!) "
        self.performSegueWithIdentifier("composeTweetFromDetailSegue", sender: self)
        
    }
    
    @IBAction func onRetweetButtonClicked(sender: AnyObject) {
        //additionalText = "RT: \"\(tweetText!)\""
        //self.performSegueWithIdentifier("composeTweetFromDetailSegue", sender: self)
        
        if tweet!.retweeted {
            var alert = UIAlertController(title: "Already RT'd", message: "You've already retweeted this!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            TwitterClient.sharedInstance.reTweetWithCompletion(tweet!.tweetId!, completion: { (error) -> () in
                if error != nil {
                    var alert = UIAlertController(title: "Success", message: "Tweet retweeted!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                        nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    self.tweet?.retweeted = true
                    self.numRetweetsLabel.text = String(self.numRetweets!.toInt()! + 1)
                }
            })
        }
    }
    
    @IBAction func onFavoriteButtonClicked(sender: AnyObject) {
        
        if tweet!.favorited {
            var alert = UIAlertController(title: "Already Favorited", message: "You've already favorited this tweet!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            TwitterClient.sharedInstance.favoriteWithCompletion(tweet!.tweetId!, completion: { (error) -> () in
                if error != nil {
                    var alert = UIAlertController(title: "Success", message: "Tweet favorited!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                        nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    self.tweet?.favorited = true
                    self.numFavoritesLabel.text = String(self.numFavorites!.toInt()! + 1)
                }
            })
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "composeTweetFromDetailSegue" {
            
            // Set up the additional text
            var twc: TweetViewController = segue.destinationViewController as! TweetViewController
            twc.startingText = additionalText
        }
    }

}
