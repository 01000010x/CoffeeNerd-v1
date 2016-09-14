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
    
    func drawButtonBorders(sides: [String], color: UIColor) {
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
    
    func drawBottomLine(color: UIColor) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, self.frame.height-1, self.frame.width, 1)
        bottomBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(bottomBorder)
    }
    
    func drawTopLine(color: UIColor) {
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0.0, 0.0, self.frame.width, 1)
        topBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(topBorder)
    }
    
    func drawRightLine(color: UIColor) {
        let rightBorder = CALayer()
        rightBorder.frame = CGRectMake(self.frame.width-1, 0.0, 1.0, self.frame.height)
        rightBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(rightBorder)
    }
    
    func drawLeftLine(color: UIColor) {
        let leftBorder = CALayer()
        leftBorder.frame = CGRectMake(0.0, 0.0, 1.0, self.frame.height)
        leftBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(leftBorder)
    }
}