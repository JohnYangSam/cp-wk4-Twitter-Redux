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
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        requestSerializer.removeAccessToken() // Clear the current access token when relogging in
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "svitwitterdemoexample://oauth")!, scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            // Use this to open another application through a URL
            
            // Open the Twitter URL so that we can go to the webpage to authenticate the application
            UIApplication.sharedApplication().openURL(authURL!)
            
        }, failure: { (error:NSError!) -> Void in
            
            println("Failed to get the token")
            self.loginCompletion?(user: nil, error: error)
        })
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
            
           
            
            
        }) { (error: NSError!) -> Void in
            
            println("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        self.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("Got home timeline")
            //println("home timeline:\(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
        }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
            println("Error getting user's home timeline")
            completion(tweets: nil, error: error)
        })
    }
    
    func postTweetWithCompletion(tweet: String, completion: (error: NSError?) -> ()) {
        self.POST("1.1/statuses/update.json", parameters: ["status": tweet], success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            completion(error: nil)
            
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
            completion(error: error)
            
        }
    }
    
    func reTweetWithCompletion(tweetId: String, completion: (error: NSError?) -> ()) {
        self.POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, error: AnyObject!) -> Void in
            
            completion(error: nil)
            
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
                completion(error: error)
        }
    }

    func favoriteWithCompletion(tweetId: String, completion: (error: NSError?) -> ()) {
        self.POST("1.1/favorites/create.json", parameters: ["id": tweetId], success: { (operation, response) -> Void in
            
            completion(error: nil)
            
        }, failure: { (operation, error) -> Void in
                
            completion(error: error)
        })
    }
    
    
    func userTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        self.GET("1.1/statuses/user_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("Got user timeline")
            //println("user timeline:\(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                println("Error getting user's home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func mentionsWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        self.GET("1.1/statuses/mentions_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("Got user timeline")
            //println("user timeline:\(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                println("Error getting user's home timeline")
                completion(tweets: nil, error: error)
        })
    }

    
}
