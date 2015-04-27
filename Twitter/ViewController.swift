//
//  ViewController.swift
//  Twitter
//
//  Created by John YS on 4/23/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "svitwitterdemoexample://oauth")!, scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            // Use this to open another application through a URL
            UIApplication.sharedApplication().openURL(authURL!)
        }, failure: { (error:NSError!) -> Void in
            println("Failed to get the token")
        })
    }
    
}

