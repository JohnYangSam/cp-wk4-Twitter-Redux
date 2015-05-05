//
//  ContainerViewController.swift
//  Twitter
//
//  Created by John YS on 5/5/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, SidePanelViewControllerDelegate, UIGestureRecognizerDelegate {
    
    var profileViewController: ProfileViewController!
    var timelineNavController: TimelineNavController!
    var timelineViewController: TimelineViewController!
    var mentionsViewController: MentionsViewController!
    var sidePanelViewController: SidePanelViewController!
    
    
    var panelVisible:Bool = false

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("LoadedContainerView")

        // Do any additional setup after loading the view.
        
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        // Setup timeline
        timelineNavController = storyBoard.instantiateViewControllerWithIdentifier("TimelineNavigationController") as! TimelineNavController
        timelineViewController = timelineNavController.childViewControllers[0] as! TimelineViewController
        
        // Display the timeline in the container
        displayViewController(timelineNavController)
        
        sidePanelViewController = storyBoard.instantiateViewControllerWithIdentifier("SidePanelViewController") as! SidePanelViewController
        
        sidePanelViewController.delegate = self
        
        // Insert the side panel into the container
        //view.insertSubview(sidePanelViewController.view, atIndex: 0)
        //addChildViewController(sidePanelViewController)
        //view.addSubview(sidePanelViewController.view)
        //sidePanelViewController.didMoveToParentViewController(self)
        
        // Setup profile
        profileViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileViewController.user = User.currentUser
        
        // Setup mentions
        mentionsViewController = storyBoard.instantiateViewControllerWithIdentifier("MentionsViewController") as! MentionsViewController
        mentionsViewController.user = User.currentUser
        
        // Add gestures
        var tapGesture = UITapGestureRecognizer(target: self, action: "onTapGesture:")
        tapGesture.delegate = self
        containerView.addGestureRecognizer(tapGesture)
        
        var edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePanLeft:")
        edgePanGesture.edges = UIRectEdge.Left
        view.addGestureRecognizer(edgePanGesture)
        
        // Re-add the timeline on top
        displayViewController(timelineNavController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // To open the panel
    func onEdgePanLeft(sender: UIScreenEdgePanGestureRecognizer) {
        //println("EdgePanLeftGesture Recognized")
        if sender.state == UIGestureRecognizerState.Ended {
            animatePanel(true)
        }
    }
    
    // To close the panel
    func onTapGesture(sender: UITapGestureRecognizer) {
        println("Tap Gesture Recognized")
        if sender.state == UIGestureRecognizerState.Ended {
            animatePanel(false)
        }
    }
    
    func animatePanel(expand: Bool) {
        if(expand) {
            panelVisible = true
            slideCenterPanel(CGRectGetWidth(containerView.frame) - 140)
        } else {
            slideCenterPanel(CGFloat(0))
            panelVisible = false
        }
    }
    
    // Slide the center panel to finalPos
    func slideCenterPanel(finalPos: CGFloat) {
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.containerView.frame.origin.x = finalPos
            }) { (complete: Bool) -> Void in
                // Nothing
                println("Sliding completed")
        }
    }
    
    // We only want this to recieve the touch for closing the menu if the menu is visible
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return panelVisible
    }
    
    
    // Side Panel View Controller Delegate Methods
    func toggleSidePanel() {
        println("toggle Side Panel called")
        animatePanel(panelVisible)
    }
    
    func showProfile() {
        profileViewController.user = User.currentUser
        displayViewController(profileViewController)
        animatePanel(false)
        
    }
    
    func showTimeline() {
        displayViewController(timelineViewController)
        animatePanel(false)
        
    }
    
    func showMentions() {
        mentionsViewController.user = User.currentUser
        displayViewController(mentionsViewController)
        animatePanel(false)
        
    }
    
    func displayViewController(viewController: UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
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
