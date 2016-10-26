//
//  BrewSettingList.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/10/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class represent the Brew Setting List recorded by the user
// The class is a singleton because that list will be used in almost every view controller
// -----------------------------------------------------------------------------------------------------

import UIKit

class BrewSettingList: NSObject {
    
    // Singleton
    static let sharedInstance = BrewSettingList()
    
    // Path of the archive to save and load the list
    private lazy var itemArchiveURL: NSURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("item.archive") as NSURL
    }()
    
    // Lazy initiation of the Settings list
    public lazy var settingsList: [BrewSetting] = {
        
        // Test if a BrewSetting array is found in archive
        guard let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: self.itemArchiveURL.path!) as? [BrewSetting] else {
            
            // In case we couldn't retrieve data in archive (ie: 1st launch or data erase) we initiate and return a table of BrewSetting with every settings isPosessed = false
            var firstInitSettingsList: [BrewSetting] = [BrewSetting(name: "Espresso"), BrewSetting(name: "French Press"), BrewSetting(name: "Cold Brew"),  BrewSetting(name: "Chemex"), BrewSetting(name: "V60"), BrewSetting(name: "Kalita Wave"), BrewSetting(name: "Bonmac"), BrewSetting(name: "Moka Pot"), BrewSetting(name: "Vacuum"), BrewSetting(name: "Aeropress"), BrewSetting(name: "Beehouse"), BrewSetting(name: "Eva Solo")]
            return firstInitSettingsList
        }
        
        return archivedItems
    }()
    
    // To privatize initializer
    private override init() {
        
    }
    
    // Save the BrewSettingList
    func save() {
        NSKeyedArchiver.archiveRootObject(settingsList, toFile: itemArchiveURL.path!)
    }
}
