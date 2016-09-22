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

    let separatorDarkGreyColor = UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func drawAllSeparatorLines() {
        // Draw 1st line (under menu view)
        var start = CGPoint(x: 0, y: 0)
        var end = CGPoint(x: underMenuView.frame.width, y: 0)
        underMenuView.drawLine(start, end: end, color: ProjectColors.SeparatorColor.LightGrey)
        
        // Draw 2nd line (under settings view)
        start = CGPoint(x: 20, y: underSettingsView.frame.height / 2)
        end = CGPoint(x: underSettingsView.frame.size.width - 20, y: underSettingsView.frame.height / 2)
        underSettingsView.drawLine(start, end: end, color: ProjectColors.SeparatorColor.DarkGrey)
        
        // Draw 3rd line (under your coffee view)
        start = CGPoint(x: 20, y: underYourCoffeeView.frame.height / 2)
        end = CGPoint(x: underYourCoffeeView.frame.width - 20, y: underYourCoffeeView.frame.height / 2)
        underYourCoffeeView.drawLine(start, end: end, color: ProjectColors.SeparatorColor.DarkGrey)
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
