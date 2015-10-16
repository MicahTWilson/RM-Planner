//
//  ViewController.swift
//  RM Planner
//
//  Created by Micah Wilson on 8/28/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import UIKit

class DailyPlansViewController: UIViewController, DatePickerDelegate {
    var dailyPlansView: DailyPlansView!
    var dailyGoalsVC: DailyGoalsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyPlansView = self.view as! DailyPlansView
        dailyPlansView.drawerButton.addTarget(self, action: "openDrawer:", forControlEvents: .TouchUpInside)
        dailyPlansView.dateSelectionView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        dailyGoalsVC = storyboard!.instantiateViewControllerWithIdentifier("dailyGoalsVC") as! DailyGoalsViewController
        dailyGoalsVC.view.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
        dailyGoalsVC.parentVC = self
        dailyGoalsVC.view.userInteractionEnabled = true
        self.view.addSubview(dailyGoalsVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dateTapped(gesture: UITapGestureRecognizer) {
        print("Date Tapped")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let previousPoint = touch.previousLocationInView(self.view)
            let currentPoint = touch.locationInView(self.view)
            let currentTranslation = self.view.transform.tx
            
            self.view.transform = CGAffineTransformMakeTranslation(currentTranslation + (currentPoint.x - previousPoint.x), 0)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.view.transform.tx < -self.view.frame.width/2 {
            print("Display Goals View")
            setGoalsView()
        } else {
            print("Display Plans View")
            setPlansView()
        }
    }
    
    func setPlansView() {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.view.transform = CGAffineTransformMakeTranslation(0, 0)
        }
    }
    
    func setGoalsView() {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.width, 0)
        }
    }

    func openDrawer(drawerButton: UIButton) {
        drawerButton.selected = !drawerButton.selected
        dailyPlansView.bringSubviewToFront(dailyPlansView.dateSelectionView)
        dailyPlansView.dateSelectionView.pickerCollectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 14, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
        
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            if drawerButton.selected {
                self.dailyPlansView.dateSelectionView.transform = CGAffineTransformMakeTranslation(0, -60)
            } else {
                self.dailyPlansView.dateSelectionView.transform = CGAffineTransformMakeTranslation(0, 0)
            }
            }, completion: nil)
    }
    
    func didSelectDate(date: NSDate) {
        if date.timeIntervalSinceDate(dailyPlansView.date) < 80000 && date.timeIntervalSinceDate(dailyPlansView.date) > -80000 {
            return
        }
        
        if date.timeIntervalSinceDate(dailyPlansView.date) > 0 {
            UIView.transitionWithView(self.dailyPlansView, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlUp, animations: nil, completion: nil)
        } else {
            UIView.transitionWithView(self.dailyPlansView, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlDown, animations: nil, completion: nil)
        }
        
        dailyPlansView.date = date
        dailyPlansView.updateView()
        
        
    }
    
}

