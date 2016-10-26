//
//  UIView+RoundedCorners.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/15/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class extension provide a function to draw rounded corners on a view

import Foundation
import UIKit

extension UIView {
    func drawRoundedCornerView(corners: UIRectCorner) {
        let rectShape = CAShapeLayer()
        setNeedsLayout()
        layoutIfNeeded()
        
        rectShape.frame = self.bounds
        
        let shapePath: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10))
        rectShape.path = shapePath.cgPath
        
        self.layer.mask = rectShape
        self.layer.masksToBounds = true
        
        let borderShape = CAShapeLayer()
        borderShape.frame = self.bounds
        borderShape.path = shapePath.cgPath
        borderShape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(borderShape)
        print("roundedFunc")
    }
}
