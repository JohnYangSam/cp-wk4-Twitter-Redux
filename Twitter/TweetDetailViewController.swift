//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by John YS on 4/28/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    // Outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    
    // Instance variables
    var additionalText:String = ""
    var tweet:Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button callbacks
    @IBAction func onReplyClick(sender: AnyObject) {
        self.performSegueWithIdentifier("composeTweetFromDetailSegue", sender: self)
    }

    @IBAction func onReplyButtonClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onRetweetButtonClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onFavoriteButtonClicked(sender: AnyObject) {
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
