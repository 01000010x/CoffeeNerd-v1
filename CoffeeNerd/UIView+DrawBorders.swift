//
//  Extensions.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/12/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class extension provides functions to draw and set a line on each side of a view


import Foundation
import UIKit

extension UIView {
    
    func drawBottomLine(_ color: UIColor, padding: CGFloat) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.height - padding, width: self.frame.width, height: 1)
        bottomBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    
    func drawTopLine(_ color: UIColor, padding: CGFloat) {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: padding - 1, width: self.frame.width, height: 1)
        topBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(topBorder)
    }
    
    func drawRightLine(_ color: UIColor, padding: CGFloat) {
        let rightBorder = CALayer()
        rightBorder.frame = CGRect(x: self.frame.width - padding, y: 0.0, width: 1.0, height: self.frame.height)
        rightBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(rightBorder)
    }
    
    func drawLeftLine(_ color: UIColor, padding: CGFloat) {
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: padding - 1, y: 0.0, width: 1.0, height: self.frame.height)
        leftBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(leftBorder)
    }
}
