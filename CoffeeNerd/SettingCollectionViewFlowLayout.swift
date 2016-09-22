//
//  SettingCollectionViewFlowLayout.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/15/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class SettingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = 2
            
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns
            return CGSize(width: itemWidth, height: 60)
        }
    }
    
    override var headerReferenceSize: CGSize {
        set {
            
        }
        get {
            return CGSize(width: self.collectionView!.frame.width, height: 60)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
