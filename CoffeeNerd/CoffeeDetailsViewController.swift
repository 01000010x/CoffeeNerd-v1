//
//  CoffeeDetailsViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class CoffeeDetailsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var containerBottomView: UIView!
    
    var coffeeBean: CoffeeBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawAllSeparatorLines()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawAllSeparatorLines() {
        // Draw 1st line (under menu view)
        let start = CGPoint(x: containerBottomView.frame.width / 10.0, y: 0)
        let end = CGPoint(x: containerBottomView.frame.width - (containerBottomView.frame.width / 10.0), y: 0)
        containerBottomView.drawLine(start, end: end, color: UIColor.white)
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
