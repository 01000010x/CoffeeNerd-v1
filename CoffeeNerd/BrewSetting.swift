//
//  BrewSetting.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/14/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class represent a Brewing method. 
// The User can choose any number of method of BrewSetting in the setting tab
// The BrewSetting chosen in the settings will constitute a list that will be saved in the user info
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class BrewSetting: NSObject, NSCoding {
    let name: String
    var isPosessed: Bool
    
    init(name: String) {
        self.name = name
        isPosessed = false
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        isPosessed = aDecoder.decodeBool(forKey: "isPosessed")
        super.init()
    }
    
    // Return the icon for the NORMAL state
    func iconNotSelected() -> UIImage {
        if let image = UIImage(named: self.name) {
            return image
        } else {
            return UIImage(named: "Default")!
        }
    }
    
    // Return the icon for the SELECTED state
    func iconSelected() -> UIImage {
        if let image = UIImage(named: "\(self.name)White") {
            return image
        } else {
            return UIImage(named: "Default")!
        }
    }
    
    // Return the NORMAL state icon in a SMALLER dimension
    func iconSmall() -> UIImage {
        if let image = UIImage(named: "\(self.name)Small") {
            return image
        } else {
            return UIImage(named: "Default")!
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(isPosessed, forKey: "isPosessed")
    }
    
}
