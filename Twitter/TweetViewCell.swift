//
//  TweetViewCell.swift
//  Twitter
//
//  Created by John YS on 4/27/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

// TODO Should a delegate be used for buttons?
protocol TweetViewCellDelegate {
    func retweetTweet(tweetId: String)
    func favoriteTweet(tweetId: String)
    func replyToTweet(screenname: String)
}


class TweetViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    // TODO: This is hack to get the twitter id - instance variables for some reason aren't persisting
    @IBOutlet weak var tweetIdLabel: UILabel!
    
    // Tweet
    //var tweetId: String?
    //var tweet: Tweet?
    
    // Additional vars
    var delegate: TimelineViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        println("tweetId: \(tweetIdLabel.text)")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // NOTE THAT THIS IS HIDDEN BECAUSE IT IS NOT FINISHED
    
    // Button Clicks
    @IBAction func onCellReplyClicked(sender: AnyObject) {
        delegate.replyToTweet(screenNameLabel.text!)
    }
    
    @IBAction func onCellRetweetClicked(sender: AnyObject) {
        delegate.retweetTweet(tweetIdLabel.text!)
    }
    
    @IBAction func onCellFavoriteClicked(sender: AnyObject) {
        println("tweetId in favorite: \(tweetIdLabel.text)")
        delegate.favoriteTweet(tweetIdLabel.text!)
    }
    
}
