//
//  TweetViewController.swift
//  Twitter
//
//  Created by John YS on 4/27/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var composeView: UITextView!
    
    // Instance Variables
    var startingText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if startingText != "" {
            composeView.text = startingText
        } else {
            composeView.text = "Enter your tweet here."
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelClick(sender: AnyObject) {
        println("Cancel clicked")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onTweetClicked(sender: AnyObject) {
        let tweetText: String = composeView.text!
        TwitterClient.sharedInstance.postTweetWithCompletion(tweetText, completion: { (error) -> () in
            self.navigationController?.popViewControllerAnimated(true)
        })
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
