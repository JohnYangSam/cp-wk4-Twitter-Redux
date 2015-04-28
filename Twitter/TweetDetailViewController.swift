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
        self.performSegueWithIdentifier("composeTweetFromDetailSegue", sender: self)
    }

    @IBAction func onReplyButtonClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onRetweetButtonClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onFavoriteButtonClicked(sender: AnyObject) {
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
