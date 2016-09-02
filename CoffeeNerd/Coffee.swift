//
//  Coffee.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class Coffee: NSObject {
    var name: String
    var country: String
    var shop: String? // Create a class or struct shop later with gmap api info
    var brewTypeArray: [BrewType]?

    
    init(name: String, country: String, shop: String?, brewTypeArray: [BrewType]?){
        self.name = name
        self.country = country
        
        if let shopProvided = shop {
            self.shop = shopProvided
        } else {
            self.shop = nil
        }
        
        if let brewTypeArrayProvided = brewTypeArray {
            self.brewTypeArray = brewTypeArrayProvided
        } else {
            self.brewTypeArray = nil
        }
    }
}
