//
//  PlannerTextField.swift
//  RM Planner
//
//  Created by Micah Wilson on 10/15/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

class PlannerTextField: UITextField, UITextFieldDelegate {
    let completedFieldButton = UIButton()
    var parentView: UIView!
    var distanceMoved: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(completedFieldButton)
        completedFieldButton.frame = CGRectMake(bounds.width - bounds.height, 0, bounds.height, bounds.height)
        completedFieldButton.backgroundColor = UIColor.clearColor()
        completedFieldButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        completedFieldButton.layer.borderWidth = 1.0
        completedFieldButton.addTarget(self, action: "completedField:", forControlEvents: .TouchUpInside)
        completedFieldButton.setImage(UIImage(named: "checkMarkIcon"), forState: UIControlState.Selected)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        self.returnKeyType = .Done
        self.delegate = self

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        if self.editing {
            while CGRectIntersectsRect(keyboardFrame, self.frame) {
                self.distanceMoved--
                self.frame.origin.y--
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y -= distanceMoved
        distanceMoved = 0
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    func completedField(sender: UIButton) {
        completedFieldButton.selected = !completedFieldButton.selected
        
    }
    
}
