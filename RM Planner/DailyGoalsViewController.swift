//
//  DailyGoalsViewController.swift
//  RM Planner
//
//  Created by Micah Wilson on 10/15/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

class DailyGoalsViewController: UIViewController {
    var parentVC: UIViewController!
    var distance: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let previousPoint = touch.previousLocationInView(self.view)
            let currentPoint = touch.locationInView(self.view)
            let currentTranslation = -self.parentVC.view.frame.width
            distance += currentPoint.x - previousPoint.x
            self.parentVC.view.transform = CGAffineTransformMakeTranslation(currentTranslation + (distance), 0)
            //self.parentVC.view.transform = CGAffineTransformTranslate(self.parentVC.view.transform, currentPoint.x - previousPoint.x, 0)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        nextResponder()?.touchesEnded(touches, withEvent: event)
        distance = 0
        if self.parentVC.view.transform.tx < -self.parentVC.view.frame.width/2 {
            print("Display Goals View")
            setGoalsView()
        } else {
            print("Display Plans View")
            setPlansView()
        }
    }
    
    func setPlansView() {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.parentVC.view.transform = CGAffineTransformMakeTranslation(0, 0)
        }
    }
    
    func setGoalsView() {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.parentVC.view.transform = CGAffineTransformMakeTranslation(-self.parentVC.view.frame.width, 0)
        }
    }
}
