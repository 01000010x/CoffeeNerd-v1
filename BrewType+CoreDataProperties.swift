//
//  BrewType+CoreDataProperties.swift
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


extension BrewType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BrewType> {
        return NSFetchRequest<BrewType>(entityName: "BrewType");
    }

    @NSManaged public var brewingMethodName: String
    @NSManaged public var groundSetting: String
    @NSManaged public var groundWeight: Int32
    @NSManaged public var brewingTimeSeconds: Int32
    @NSManaged public var brewingTimeMinutes: Int32

}
