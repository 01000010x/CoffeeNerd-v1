//
//  CoffeeBean+CoreDataClass.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/28/16.
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

// Error throwable when looking for a BrewType in the BrewTypeList
enum CoffeeError: Error {
    case NoBrewTypeToReturn(message: String)
}

public class CoffeeBean: NSManagedObject {
    // Class Identifier
    static let identifier: String = "CoffeeBean"
    
    // Add a BrewType object to the CoffeeBean BrewTypeList
    func addBrewTypeObject(brewType: NSManagedObject) {
        let currentBrewTypes = mutableSetValue(forKey: "brewTypes")
        currentBrewTypes.add(brewType)
    }
    
    // Remove a BrewType object from the CoffeeBean BrewTypeList
    func removeBrewTypeObject(brewType: NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "brewTypes")
        currentTags.remove(brewType)
    }
    
    // Method only created for tests // Display the BrewTypeList regardless of the settings
    func displayBrewTypes() {
        for brewType in self.brewTypes {
            let brewTypeObject = brewType as! BrewType
            print(brewTypeObject.brewingMethodName)
        }
    }
    
    // Return a BrewType with a particular name
    func brewType(withName name: String) throws -> BrewType {
        var brewTypeToReturn: BrewType? = nil
        
        for brewType in self.brewTypes {
            let brewTypeObject = brewType as! BrewType
            if brewTypeObject.brewingMethodName == name {
                brewTypeToReturn = brewTypeObject
            }
        }
        
        guard (brewTypeToReturn != nil) else {
            throw CoffeeError.NoBrewTypeToReturn(message: "No corresponding BrewType found, you have to create one and add it to the coffee Bean. This is probably due to a the user that add a new brewing method in its settings after that bean was created")
        }
        
        return brewTypeToReturn!
    }
    
}
