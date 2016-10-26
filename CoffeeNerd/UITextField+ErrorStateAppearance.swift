//
//  UITextField+ErrorStateAppearance.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/17/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class extension provide a function to create an error state on an UITextField
// Appearance in normal and error state has to be different to gives the user a fast clue on what's wrong

import Foundation
import UIKit

extension UITextField {

    func configureTextField(forState state: String) {
        if state == "error" {
            self.backgroundColor = ProjectColors.Red.backgroundError
            self.layer.borderWidth = 1
        } else {
            self.backgroundColor = UIColor.clear
            self.layer.masksToBounds = true
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 0
        }
    }
}
