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

    // MARK: Variables and Outlets
    
    @IBOutlet var containerBottomView: UIView!
    @IBOutlet var coffeeNameLabel: UILabel!
    @IBOutlet var coffeeOriginLabel: UILabel!
    @IBOutlet var coffeeShopLabel: UILabel!
    @IBOutlet var brewTypeWeightLabel: UILabel!
    @IBOutlet var brewTypeGrindLabel: UILabel!
    @IBOutlet var brewTypeNameLabel: UILabel!
    @IBOutlet var brewTypeIcon: UIImageView!
    
    var coffeeBean: CoffeeBean?
    var brewType: BrewType?
    var brewSetting: BrewSetting?
    
    
    // MARK: View Controller
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTextLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawAllSeparatorLines()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Internal functions
    
    func drawAllSeparatorLines() {
        // Draw 1st line (under menu view)
        let start = CGPoint(x: containerBottomView.frame.width / 10.0, y: 0)
        let end = CGPoint(x: containerBottomView.frame.width - (containerBottomView.frame.width / 10.0), y: 0)
        containerBottomView.drawLine(start, end: end, color: UIColor.white)
    }
    
    func initTextLabels() {
        coffeeNameLabel.text = coffeeBean?.name
        coffeeOriginLabel.text = coffeeBean?.origin
        coffeeShopLabel.text = coffeeBean?.shop
    }
    
    @IBAction func closeViewButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
    
    
}
