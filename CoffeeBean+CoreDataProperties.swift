//
//  CoffeeBean+CoreDataProperties.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/29/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class represent the CoffeeBean entity in CoreData.
// A CoffeeBean represent a coffee bean irl :
// - a coffee name
// - a coffe origin
// - a coffe shop
// - a bool variable telling if it's caffeinated or not
// - a weight setting
// - a brewing time setting
//
// -----------------------------------------------------------------------------------------------------

import Foundation
import CoreData


extension CoffeeBean {

    // Return a fetchRequest. This request request for all the CoffeeBeans in CoreData, ordered by alphabetical ascending
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoffeeBean> {
        let request = NSFetchRequest<CoffeeBean>(entityName: CoffeeBean.identifier)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    
    @NSManaged public var name: String
    @NSManaged public var origin: String
    @NSManaged public var shop: String
    @NSManaged public var isCaffeinated: Bool
    @NSManaged var brewTypes: Set<NSManagedObject>

}
