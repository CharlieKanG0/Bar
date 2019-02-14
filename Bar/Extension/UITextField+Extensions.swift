//
//  UITextField+Extensions.swift
//  Bar
//
//  Created by Charlie Kang on 14/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    // MARK: Done button
    // Add done button to the keyboard tool bar - dismiss the keyboard
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    // MARK: Next button
    // Add next button to the keyboard tool bar - move to the next textfield
    @IBInspectable var nextAccessory: Bool{
        get{
            return self.nextAccessory
        }
        set (hasDone) {
            if hasDone{
                addNextButtonOnKeyboard()
            }
        }
    }
    
    func addNextButtonOnKeyboard()
    {
        let nextToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        nextToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let next: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.nextButtonAction))
        
        let items = [flexSpace, next]
        nextToolbar.items = items
        nextToolbar.sizeToFit()
        
        self.inputAccessoryView = nextToolbar
    }
    
    @objc func nextButtonAction()
    {
        self.resignFirstResponder()
    }
}
