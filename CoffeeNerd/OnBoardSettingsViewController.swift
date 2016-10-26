//
//  OnBoardSettingsViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/26/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class OnBoardSettings: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: Constants and Variables Declaration
    
    // Singleton instance for Brewing Settings List
    let brewSettingList = BrewSettingList.sharedInstance.settingsList
    var alert:UIAlertController!
    
    // MARK: View Controller
    
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
        return brewSettingList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCellView", for: indexPath) as! SettingCellView
        let selected = brewSettingList[(indexPath as NSIndexPath).row].isPosessed
        cell.labelView.text = brewSettingList[(indexPath as NSIndexPath).row].name
        updateCellAppearance(cell, atIndexPath: indexPath, isSelected: selected)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview: UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableCell", for: indexPath) as! HeaderReusableCell
            reusableview = headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterSettings", for: indexPath) as! FooterSettingsCollectionView
            reusableview = footerView
        }
        
        return reusableview
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SettingCellView
        if brewSettingList[(indexPath as NSIndexPath).row].isPosessed {
            brewSettingList[(indexPath as NSIndexPath).row].isPosessed = false
            updateCellAppearance(cell, atIndexPath: indexPath, isSelected: false)
        } else {
            brewSettingList[(indexPath as NSIndexPath).row].isPosessed = true
            updateCellAppearance(cell, atIndexPath: indexPath, isSelected: true)
        }
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.view.frame.size.width - 30) / 2.0
        let cellHeight = (self.view.frame.size.height - self.collectionView.frame.origin.y) / 8
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    }
    
    
    
    // MARK: Internal Controller Functions
    
    func updateCellAppearance(_ cell: SettingCellView, atIndexPath indexPath: IndexPath, isSelected selected: Bool) {
        if selected {
            cell.labelView.font = UIFont(name: "Raleway-Bold", size: 14.0)
            cell.labelView.textColor = UIColor.white
            cell.contentView.backgroundColor = ProjectColors.Blue.medium
            cell.itemImageView.image = brewSettingList[(indexPath as NSIndexPath).row].iconSelected()
        } else {
            cell.labelView.font = UIFont(name: "Raleway-Bold", size: 14.0)
            cell.labelView.textColor = ProjectColors.Grey.medium
            cell.contentView.backgroundColor = ProjectColors.Grey.light
            cell.itemImageView.image = brewSettingList[(indexPath as NSIndexPath).row].iconNotSelected()
        }
    }
    

    @IBAction func validateButtonTapped(_ sender: AnyObject) {
        if BrewSettingList.sharedInstance.settingsList.index(where: ({$0.isPosessed == true})) != nil {
            BrewSettingList.sharedInstance.save()
            performSegue(withIdentifier: "presentTabBar", sender: self)
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        self.alert = UIAlertController(title: nil, message: "Pick a least one brewing method :3", preferredStyle: UIAlertControllerStyle.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(OnBoardSettings.dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert(){
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
    }
}
