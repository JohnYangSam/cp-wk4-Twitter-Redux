//
//  User.swift
//  Twitter
//
//  Created by John YS on 4/27/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey: String = "keyForCurrentTwitterUser"
let userDidLogoutNotification: String = "userDidLogoutNotificationTwitterUser"
let userDidLoginNotification: String = "userDidLoginNotificationTwitterUser"

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var numTweets: String?
    var numFollowers: String?
    var numFollowing: String?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        //println("user dic: \(dictionary)")
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        numTweets =  String(dictionary["statuses_count"] as! Int)
        numFollowers = String(dictionary["followers_count"] as! Int)
        numFollowing = String(dictionary["following"] as! Int)
    }
    
    // Special class variable with a getter and setter
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            if _currentUser == nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    
    }
   
}
