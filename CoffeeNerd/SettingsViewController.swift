//
//  SettingsViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/11/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    // MARK: Constants and Variables Declaration
    
    // List of the possible brew method in the app - will evolve depending on the user will
    var settingsList: [BrewSetting] = [BrewSetting(name: "Espresso"), BrewSetting(name: "French Press"), BrewSetting(name: "Cold Brew"),  BrewSetting(name: "Chemex"), BrewSetting(name: "V60"), BrewSetting(name: "Kalita Wave"), BrewSetting(name: "Bonmac"), BrewSetting(name: "Italian"), BrewSetting(name: "Vacuum"), BrewSetting(name: "Aeropress"), BrewSetting(name: "Bee House"), BrewSetting(name: "Eva Solo")]
    
    // Place where are stored the app settings (ie: Which brew methods did the user select
    let itemArchiveURL: NSURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("item.archive") as NSURL
    }()
    
    
    
    // MARK: View Controller
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.reloadData()
    }

    
    
    // MARK: Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCellView", for: indexPath) as! SettingCellView
        let selected = settingsList[(indexPath as NSIndexPath).row].isPosessed
        cell.labelView.text = settingsList[(indexPath as NSIndexPath).row].name
        updateCellAppearance(cell, atIndexPath: indexPath, isSelected: selected)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview: UICollectionReusableView
        
       // if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableCell", for: indexPath) as! HeaderReusableCell
            headerView.headerLabel.text = "What kind of brewing method\ndo you use?"
            reusableview = headerView
       
        
        return reusableview
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SettingCellView
        if settingsList[(indexPath as NSIndexPath).row].isPosessed {
            settingsList[(indexPath as NSIndexPath).row].isPosessed = false
            updateCellAppearance(cell, atIndexPath: indexPath, isSelected: false)
        } else {
            settingsList[(indexPath as NSIndexPath).row].isPosessed = true
            updateCellAppearance(cell, atIndexPath: indexPath, isSelected: true)
        }
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.view.frame.size.width - 1) / 2.0
        let cellHeight = (self.view.frame.size.height - self.collectionView.frame.origin.y - 176) / 6
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1.0, 0, 1.0, 0)
    }
    
    
    // MARK: Internal Controller Functions
    
    func updateCellAppearance(_ cell: SettingCellView, atIndexPath indexPath: IndexPath, isSelected selected: Bool) {
        if selected {
            cell.labelView.font = UIFont(name: "Raleway-Medium", size: 14.0)
            cell.labelView.textColor = ProjectColors.Sand
            cell.contentView.backgroundColor = ProjectColors.Brown.Dark
            cell.itemImageView.image = settingsList[(indexPath as NSIndexPath).row].iconSelected()
        } else {
            cell.labelView.font = UIFont(name: "Raleway-light", size: 14.0)
            cell.labelView.textColor = ProjectColors.Brown.Dark
            cell.contentView.backgroundColor = ProjectColors.Sand
            cell.itemImageView.image = settingsList[(indexPath as NSIndexPath).row].iconNotSelected()
        }
    }
    
    
    func presentListViewController() {
        let listView =  self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! CoffeeListViewController
        self.present(listView, animated: true, completion: nil)
    }
    
    
    func presentAlertPickABrewingMethod() {
        let alertController = UIAlertController(title: "Brewing Method Missing", message: "You must pick at least one brewing method", preferredStyle: .alert)
        let callAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(callAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func isBrewMethodWasPicked() -> Bool {
        var brewingMethodPicked: Int = 0
        
        for setting in settingsList {
            if setting.isPosessed == true {
                brewingMethodPicked += 1
            }
        }
        
        if brewingMethodPicked == 0 {
            return false
        } else {
            return true
        }
    }
    
    
    // Replace saving / loading and controller var : settingsList with a CoffeeSettings Class and a
    // a singleton design pattern on app delegate level.
    // instead of creating the load functions and the two variables in each controller needed it
    func saveSettings() {
        NSKeyedArchiver.archiveRootObject(settingsList, toFile: itemArchiveURL.path!)
    }
    
    
    func loadSettings() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [BrewSetting] {
            settingsList = archivedItems
        }
    }


    
    // MARK: IBActions
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        if isBrewMethodWasPicked() {
            saveSettings()
            presentListViewController()
        } else {
            presentAlertPickABrewingMethod()
        }
    }
}



