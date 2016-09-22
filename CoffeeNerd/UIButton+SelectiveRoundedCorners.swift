//
//  UIButton+SelectiveRoundedCorners.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/17/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func drawRoundedCornerButton(corners: UIRectCorner) {
        let rectShape = CAShapeLayer()
        setNeedsLayout()
        layoutIfNeeded()
        /*
 A DEPLACER AILLEURS DANS LES ACTIONS
        self.backgroundColor = ProjectColors.Sand
        self.setTitleColor(ProjectColors.Brown.Dark, for: .normal)
 */
        
        rectShape.frame = self.bounds
        let shapePath: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10))
        rectShape.path = shapePath.cgPath

        self.layer.mask = rectShape
        self.layer.masksToBounds = true
        
        let borderShape = CAShapeLayer()
        borderShape.frame = self.bounds
        borderShape.path = shapePath.cgPath
        borderShape.lineWidth = 4.0
        borderShape.strokeColor = ProjectColors.Brown.Dark.cgColor
        borderShape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(borderShape)
        
        
    }
}
