//
//  BrewType+CoreDataProperties.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/29/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import CoreData


extension BrewType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BrewType> {
        return NSFetchRequest<BrewType>(entityName: "BrewType");
    }

    @NSManaged public var brewingMethodName: String
    @NSManaged public var groundSetting: String
    @NSManaged public var groundWeight: Int32
    @NSManaged public var brewingTime: Int32

}
