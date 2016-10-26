//
//  RadialGradientLayer.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/13/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// Class that create a radial gradient layer

import UIKit
import Foundation

class RadialGradientLayer: CALayer {
    
    // MARK: Properties
    
    var center:CGPoint
    var radius:CGFloat
    var colors:[CGColor]
    
    // MARK: Initializers
    
    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        self.center = center
        self.radius = radius
        self.colors = colors
        
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init(coder aDecoder: NSCoder) {
        center = CGPoint.init(x: 0, y: 0)
        radius = 0
        colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        
        super.init()
    }
    
    // MARK: Draw Function
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0,1.0])
        
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
    }
    
}
