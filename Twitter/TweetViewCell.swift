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
}


class TweetViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    // Tweet
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // NOTE THAT THIS IS HIDDEN BECAUSE IT IS NOT FINISHED
    
    // Button Clicks
    /*
    @IBAction func onReplyClick(sender: AnyObject) {
        // TODO: What is the best way to have these buttons open a new view controller. Is it a delegate?
        
    }
    
    @IBAction func onRetweetClick(sender: AnyObject) {
        // To fill in
    }
    
    @IBAction func onFavoriteClick(sender: AnyObject) {
        // To fill in
    }
    */
}
