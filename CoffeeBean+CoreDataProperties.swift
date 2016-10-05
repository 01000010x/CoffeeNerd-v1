//
//  CoffeeBean+CoreDataProperties.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/29/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import CoreData


extension CoffeeBean {

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
