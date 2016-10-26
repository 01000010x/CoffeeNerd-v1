//
//  ProjetcColors.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/11/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// That file defines the UIcolors used in the project

import Foundation
import UIKit

struct ProjectColors {
    
    struct Grey {
        static let Faded = UIColor(red: 81/255.0, green: 73/255.0, blue: 73/255.0, alpha: 0.5)
        static let light = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
        static let medium = UIColor(red: 158/255.0, green: 158/255.0, blue: 158/255.0, alpha: 1.0)
        static let deep = UIColor(red: 81/255.0, green: 81/255.0, blue: 81/255.0, alpha: 1.0)
        static let lightPlaceholder = UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 0.5)
        
    }
    
    struct SeparatorColor {
        static let LightGrey = UIColor(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1.0)
        static let lightGrey = UIColor(red: 211/255.0, green: 211/255.0, blue: 211/255.0, alpha: 1.0)
        static let DarkGrey = UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0)
    }
    
    struct Blue {
        static let deep = UIColor(red: 53/255.0, green: 51/255.0, blue: 112/255.0, alpha: 1.0)
        static let medium = UIColor(red: 79/255.0, green: 150/255.0, blue: 221/255.0, alpha: 1.0)
        static let radialStart = UIColor(red: 155/255.0, green: 205/255.0, blue: 255/255.0, alpha: 1.0)
        static let radialEnd = UIColor(red: 79/255.0, green: 150/255.0, blue: 221/255.0, alpha: 1.0)
    }
    
    struct Red {
        static let backgroundError = UIColor(red: 255/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1.0)
    }
}
