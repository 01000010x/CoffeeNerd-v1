//
//  UITextField+DoneButtonKeyboard.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/15/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class extension provide a function to add a Done Button on a keyboard. That button dismiss the keyboard
// I still can't believe this is not a standard keyboard option in Xcode


import Foundation
import UIKit

extension UITextField {
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        self.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.resignFirstResponder()
        self.resignFirstResponder()
    }
}
