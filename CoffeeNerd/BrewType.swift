//
//  BrewType.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class BrewType: NSObject {
    let ID: Int
    let coffeeID: Int
    var groundSetting: String
    var groundWeight: Float
    var brewTimeInSeconds: Int?
    
    init(ID: Int, coffeeID: Int, groundSetting: String, groundWeight: Float, brewTimeInSeconds: Int?){
        self.ID = ID
        self.coffeeID = coffeeID
        self.groundSetting = groundSetting
        self.groundWeight = groundWeight
        
        if let brewTimeInSecondsProvided = brewTimeInSeconds {
            self.brewTimeInSeconds = brewTimeInSecondsProvided
        }
    }
}
