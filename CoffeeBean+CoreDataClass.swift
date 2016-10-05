//
//  CoffeeBean+CoreDataClass.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/28/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import CoreData


public class CoffeeBean: NSManagedObject {
    static let identifier: String = "CoffeeBean"
    
    func addBrewTypeObject(brewType: NSManagedObject) {
        let currentBrewTypes = mutableSetValue(forKey: "brewTypes")
        currentBrewTypes.add(brewType)
    }
    
    func removeBrewTypeObject(brewType: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "brewTypes")
        currentTags.remove(brewType)
    }
    
    
    

  /*  static let fetchRequest: NSFetchRequest<CoffeeBean> = { // Type CoffeeBean OU NSManagedObject ????
        let request = NSFetchRequest<CoffeeBean>(entityName: CoffeeBean.identifier)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()
   */ 
}
