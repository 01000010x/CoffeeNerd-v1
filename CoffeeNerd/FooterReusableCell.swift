//
//  FooterReusableCell.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/16/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class FooterReusableCell: UICollectionReusableView {
    
    @IBOutlet var validateButton: UIButton!
    @IBOutlet var weightText: UILabel!
    @IBOutlet var weightUnitSwitch: UISegmentedControl!
    
    func initWeightSwitch(weightUnit: String) {
        let normalFont = UIFont(name: "Raleway-Medium", size: 14.0)
        let selectedFont = UIFont(name: "Raleway-Bold", size: 14.0)
        
        let normalTextAttributes: [NSObject : AnyObject] = [
        NSForegroundColorAttributeName as NSObject: UIColor.black,
        NSFontAttributeName as NSObject: normalFont!
        ]
        
        let boldTextAttributes: [NSObject : AnyObject] = [
        NSForegroundColorAttributeName as NSObject : UIColor.white,
        NSFontAttributeName as NSObject : selectedFont!,
        ]
        
        weightUnitSwitch.setTitleTextAttributes(normalTextAttributes, for: .normal)
        weightUnitSwitch.setTitleTextAttributes(normalTextAttributes, for: .highlighted)
        weightUnitSwitch.setTitleTextAttributes(boldTextAttributes, for: .selected)
        
        if weightUnit == "grams" {
            weightUnitSwitch.selectedSegmentIndex = 0
        } else {
            weightUnitSwitch.selectedSegmentIndex = 1
        }
    }
    
}
