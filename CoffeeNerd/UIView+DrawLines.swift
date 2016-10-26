//
//  UIView+DrawLines.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/13/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class extension provides a function to draw and set a line from a point to another with a defined color in a view


import Foundation
import UIKit

extension UIView {
    
    func drawLine(_ start: CGPoint, end: CGPoint, color: UIColor) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
