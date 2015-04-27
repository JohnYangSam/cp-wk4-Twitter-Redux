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
    
    // You can put Void or ()
    // This is used as the closure set by users of the API
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
    // Letting us make singletons with a nested struct that can have a stored property
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func openUrl(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken:BDBOAuth1Credential!) -> Void in
            
            println("Got the access token.")
            
            self.requestSerializer.saveAccessToken(accessToken)
            self.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                // println("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                println("user: \(user.name)") // test to see if this is working
                
                self.loginCompletion?(user: user, error: nil)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    
                println("error: \(error)")
                self.loginCompletion?(user: nil, error: error)
            })
            
            
            self.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                println("Got home timeline")
                //println("home timeline:\(response)")
                
                }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    
                    println("Error getting user's home timeline")
            })
            
            
        }) { (error: NSError!) -> Void in
            
            println("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }
        
        
        
    }
    
}
