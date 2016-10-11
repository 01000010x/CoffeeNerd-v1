//
//  BrewSettingList.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/10/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class BrewSettingList: NSObject {
    
    static let sharedInstance = BrewSettingList()
    
    private lazy var itemArchiveURL: NSURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("item.archive") as NSURL
    }()
    
    //Lazy initiation of the Settings list
    public lazy var settingsList: [BrewSetting] = {
        
        // Test if a BrewSetting array is found in archive
        guard let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: self.itemArchiveURL.path!) as? [BrewSetting] else {
            // In case we couldn't retrieve data in archive (ie: 1st launch or data erase) we initiate and return a table of BrewSetting with every settings isPosessed = false
            var firstInitSettingsList: [BrewSetting] = [BrewSetting(name: "Espresso"), BrewSetting(name: "French Press"), BrewSetting(name: "Cold Brew"),  BrewSetting(name: "Chemex"), BrewSetting(name: "V60"), BrewSetting(name: "Kalita Wave"), BrewSetting(name: "Bonmac"), BrewSetting(name: "Italian"), BrewSetting(name: "Vacuum"), BrewSetting(name: "Aeropress"), BrewSetting(name: "Bee House"), BrewSetting(name: "Eva Solo")]
            return firstInitSettingsList
        }
        
        return archivedItems
    }()
    
    // To privatize init
    private override init() {
        print("Settings Init")
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(settingsList, toFile: itemArchiveURL.path!)
    }
}
