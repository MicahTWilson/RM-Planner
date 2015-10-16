//
//  ViewController.swift
//  RM Planner
//
//  Created by Micah Wilson on 8/28/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import UIKit

class DailyPlansViewController: UIViewController {
    var dailyPlansView: DailyPlansView!
    var dailyGoalsVC: DailyGoalsViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

