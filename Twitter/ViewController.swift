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
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
            if (user != nil) {
                println("login succesful")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                println("\(error)")
                var alert = UIAlertController(title: "Signup Error", message: error?.description, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler:
                    nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
        }
    }
    
}

