//
//  DatePickerView.swift
//  RM Planner
//
//  Created by Micah Wilson on 10/15/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

@objc protocol DatePickerDelegate {
    optional func didSelectDate(date: NSDate)
}

class DatePickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var pickerCollectionView: UICollectionView!
    let numberOfWeeks = 5
    
    var delegate: DatePickerDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pickerCollectionView.delegate = self
        pickerCollectionView.dataSource = self
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (7 * numberOfWeeks)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DateCell
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.layer.borderWidth = 1
        cell.backgroundColor = UIColor.clearColor()
        cell.dateLabel.text = getDateForCell(indexPath)
        
        if indexPath.row == 17 {
            cell.dateLabel.textColor = UIColor.darkGrayColor()
        } else {
            cell.dateLabel.textColor = UIColor.grayColor()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let dateSelected = NSDate().dateByAddingTimeInterval((-24*60*60)*(17 - Double(indexPath.row)))
        self.delegate?.didSelectDate!(dateSelected)
    }
    
    func getDateForCell(indexPath: NSIndexPath) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd"
        let dateChecking = NSDate().dateByAddingTimeInterval((-24*60*60)*(17 - Double(indexPath.row)))
        
        return formatter.stringFromDate(dateChecking)
    }

}