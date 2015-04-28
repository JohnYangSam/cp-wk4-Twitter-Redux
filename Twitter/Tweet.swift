//
//  Tweet.swift
//  Twitter
//
//  Created by John YS on 4/27/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var favoriteCount: String?
    var retweetCount: String?
    var createdAtString: String?
    var createdAtDate: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        favoriteCount = dictionary["favorite_count"] as? String
        retweetCount = dictionary["retweet_count"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        // In the future, should make this a singleton because it is expensive
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EE MMM d HH:mm:ss Z y"
        createdAtDate = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets: [Tweet] = [Tweet]()
        for dict in array {
            tweets.append(Tweet(dictionary: dict))
        }
        return tweets
    }
   
}
