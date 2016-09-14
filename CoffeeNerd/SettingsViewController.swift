//
//  SettingsViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/11/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var espressoButton: UIButton!
    @IBOutlet var coldBrewButton: UIButton!
    @IBOutlet var frenchPressButton: UIButton!
    @IBOutlet var drippingButton: UIButton!
    @IBOutlet var aeropressButton: UIButton!
    @IBOutlet var italianButton: UIButton!
    @IBOutlet var vacuumButton: UIButton!
    @IBOutlet var otherButton: UIButton!
    @IBOutlet var gramsButton: UIButton!
    @IBOutlet var ozButton: UIButton!
    @IBOutlet var whatKindOfView: UIView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawAllButtonsBorders()
        drawAllSeparatorLines()
        drawRoundedCornerButtons()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawAllSeparatorLines() {
        // Draw 1st line (under menu view)
        let start = CGPointMake(0, 0)
        let end = CGPointMake(whatKindOfView.frame.width, 0)
        whatKindOfView.drawLine(start, end: end, color: ProjectColors.SeparatorColor.LightGrey)
    }
    
    func drawAllButtonsBorders() {
        espressoButton.drawButtonBorders(["Right", "Top", "Bottom"], color: ProjectColors.Brown.Dark)
        frenchPressButton.drawButtonBorders(["Right", "Bottom"], color: ProjectColors.Brown.Dark)
        aeropressButton.drawButtonBorders(["Right", "Bottom"], color: ProjectColors.Brown.Dark)
        vacuumButton.drawButtonBorders(["Right", "Bottom"], color: ProjectColors.Brown.Dark)
        coldBrewButton.drawButtonBorders(["Top", "Bottom"], color: ProjectColors.Brown.Dark)
        drippingButton.drawButtonBorders(["Bottom"], color: ProjectColors.Brown.Dark)
        italianButton.drawButtonBorders(["Bottom"], color: ProjectColors.Brown.Dark)
        otherButton.drawButtonBorders(["Bottom"], color: ProjectColors.Brown.Dark)
    }
    
    func drawRoundedCornerButtons() {
        let rectShape = CAShapeLayer()
        let corners: UIRectCorner = [.TopLeft, .BottomLeft]
        rectShape.bounds = gramsButton.frame
        rectShape.position = gramsButton.center
        
        rectShape.path = UIBezierPath(roundedRect: gramsButton.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 20)).CGPath
        rectShape.backgroundColor = UIColor.blueColor().CGColor
        rectShape.borderWidth = 2.0
        rectShape.borderColor = ProjectColors.Grey.Dark.CGColor
        gramsButton.layer.mask = rectShape.mask
        //gramsButton.layer.borderColor = ProjectColors.Grey.Dark.CGColor
        //gramsButton.layer.borderWidth = 2.0
        gramsButton.backgroundColor = UIColor.blueColor()
    }
    
    @IBAction func espressoTapped(sender: AnyObject) {
        print(espressoButton.state)
        espressoButton.selected = true
        print(espressoButton.state)
    }

}
