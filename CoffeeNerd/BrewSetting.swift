//
//  BrewSetting.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/14/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

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
        //print("NAME : \(name)")
        super.init()
    }
    
    func iconNotSelected() -> UIImage {
        if let image = UIImage(named: self.name) {
            return image
        } else {
            return UIImage(named: "Default")!
        }
    }
    
    func iconSelected() -> UIImage {
        if let image = UIImage(named: "\(self.name)White") {
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
