//
//  Extensions.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/12/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func drawButtonBorders(_ sides: [String], color: UIColor) {
        for side: String in sides {
            switch side {
            case "Left":
                self.drawLeftLine(color)
            case "Right":
                self.drawRightLine(color)
            case "Top":
                self.drawTopLine(color)
            case "Bottom":
                self.drawBottomLine(color)
            default:
                print("Wrong Parameters")
            }
        }
    }
    
    func drawBottomLine(_ color: UIColor) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.height-1, width: self.frame.width, height: 1)
        bottomBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    func drawTopLine(_ color: UIColor) {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 1)
        topBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(topBorder)
    }
    
    func drawRightLine(_ color: UIColor) {
        let rightBorder = CALayer()
        rightBorder.frame = CGRect(x: self.frame.width-1, y: 0.0, width: 1.0, height: self.frame.height)
        rightBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(rightBorder)
    }
    
    func drawLeftLine(_ color: UIColor) {
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: 0.0, y: 0.0, width: 1.0, height: self.frame.height)
        leftBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(leftBorder)
    }
}
