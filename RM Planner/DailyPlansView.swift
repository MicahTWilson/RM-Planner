//
//  DailyPlansView.swift
//  RM Planner
//
//  Created by Micah Wilson on 8/28/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import UIKit

class DailyPlansView: UIView {
    @IBOutlet weak var planerView: UIView!
    @IBOutlet weak var topPlansView: UIView!
    @IBOutlet weak var leftTimeView: UIView!
    let amountOfTime = 18
    let startTime = 6
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.planerView.layer.cornerRadius = 10
        self.planerView.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.planerView.layer.borderWidth = 1
        
        self.topPlansView.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.topPlansView.layer.borderWidth = 1
        
        self.leftTimeView.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.leftTimeView.layer.borderWidth = 1
        self.leftTimeView.layer.cornerRadius = 10
        
        for index in 0...18 {
            let yValue = topPlansView.frame.origin.y + topPlansView.frame.height + planerView.frame.origin.y
            let height = (planerView.frame.height - topPlansView.frame.height - 12) / 18
            let textField = UITextField(frame: CGRectMake(planerView.frame.origin.x, yValue - 1 + (CGFloat(index) * (height - 1)), planerView.frame.width, height))
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.darkGrayColor().CGColor
            textField.backgroundColor = UIColor.whiteColor()
            self.addSubview(textField)
        }
        
        for index in 0...self.amountOfTime {
            let distanceApart = (self.leftTimeView.frame.height - 33) / CGFloat(self.amountOfTime)
            let timeLabel = UILabel(frame: CGRectMake(0.0, (CGFloat(index) * distanceApart) + self.leftTimeView.frame.origin.y + 8, 40, 20))
            timeLabel.text = "\((self.startTime + index) % 12):00"
            timeLabel.font = UIFont(name: "Avenir-Book", size: 10)
            timeLabel.textColor = .blackColor()
            timeLabel.textAlignment = .Right
            self.addSubview(timeLabel)
            
            if (self.startTime + index) % 12 == 0 {
                timeLabel.text = "12:00"
            }
        }

    }
}
