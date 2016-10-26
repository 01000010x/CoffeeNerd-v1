//
//  BrewType+CoreDataClass.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/29/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class represent the BrewType entity in CoreData.
// A BrewType is a property of a CoffeeBean that compile 
// - a BrewSetting name 
// - a grind setting
// - a weight setting
// - a brewing time setting
//
// -----------------------------------------------------------------------------------------------------

import Foundation
import CoreData


public class BrewType: NSManagedObject {
    static let identifier: String = "BrewType"
    
}
