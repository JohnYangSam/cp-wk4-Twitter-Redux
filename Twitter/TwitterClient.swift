//
//  TwitterClient.swift
//  Twitter
//
//  Created by John YS on 4/27/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

    
let twitterConsumerKey = "UrstzR69iq1JI0WoxXEQllwPv"
let twitterConsumerSecret = "IpsACdvCHJvyai04ckglf7TgjH5F5sonQIOSiiwi2JLFzyavnK"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    // Letting us make singletons with a nested struct that can have a stored property
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    
   
}
