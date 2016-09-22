//
//  SettingCellView.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/16/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class SettingCellView: UICollectionViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var labelView: UILabel!
    
    func setSettingsItem(itemImageName: String) {
        itemImageView.image = UIImage(named: itemImageName)
    }
}
