//
//  MenuViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/4/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var yourCoffeesButton: UIButton!
    @IBOutlet var findShopButton: UIButton!
    @IBOutlet var underMenuView: UIView!
    @IBOutlet var underSettingsView: UIView!
    @IBOutlet var underYourCoffeeView: UIView!
    
    let backgroundColor = UIColor(red: 240/255.0, green: 237/255.0, blue: 227/255.0, alpha: 1.0)
    let textBrownColor = UIColor(red: 81/255.0, green: 73/255.0, blue: 73/255.0, alpha: 1.0)
    let separatorClearGreyColor = UIColor(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1.0)
    let separatorDarkGreyColor = UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawLine(selectedView: UIView, start: CGPoint, end: CGPoint, color: UIColor) {
        //design the path
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = color.CGColor
        shapeLayer.lineWidth = 1.0
        
        selectedView.layer.addSublayer(shapeLayer)
    }
    
    func drawAllSeparatorLines() {
        // Draw 1st line (under menu view)
        var start = CGPointMake(0, 0)
        var end = CGPointMake(underMenuView.frame.width, 0)
        drawLine(underMenuView, start: start, end: end, color: separatorClearGreyColor)
        
        // Draw 2nd line (under settings view)
        start = CGPointMake(20, underSettingsView.frame.height / 2)
        end = CGPointMake(underSettingsView.frame.size.width - 20, underSettingsView.frame.height / 2)
        drawLine(underSettingsView, start: start, end: end, color: separatorDarkGreyColor)
        print(underSettingsView.frame.size.width)
        // Draw 3rd line (under your coffee view)
        start = CGPointMake(20, underYourCoffeeView.frame.height / 2)
        end = CGPointMake(underYourCoffeeView.frame.width - 20, underYourCoffeeView.frame.height / 2)
        drawLine(underYourCoffeeView, start: start, end: end, color: separatorDarkGreyColor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawAllSeparatorLines()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
