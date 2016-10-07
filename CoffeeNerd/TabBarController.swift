//
//  TabBarController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/5/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var selectedItem: Int = 3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // If no settings recorded, display the settings view
        self.selectedViewController = self.viewControllers![selectedItem]
        configureTabBarColors()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.frame.size.height = 62
        self.tabBar.frame.origin.y = self.view.frame.size.height - 62
        for item in self.tabBar.items! {
            item.titlePositionAdjustment = (UIOffset(horizontal: 0, vertical: -6))
            item.imageInsets = UIEdgeInsetsMake(-4, 0, 4, 0);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Internal Functions
    
    func configureTabBarColors() {
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
        }
        
        configureItemFonts()
    }
    
    func configureItemFonts() {
        let attributesUnselected = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName : UIFont(name: "Raleway-Regular", size: 13)!]
        let attributesSelected = [NSForegroundColorAttributeName: ProjectColors.MediumBlue, NSFontAttributeName : UIFont(name: "Raleway-Bold", size: 13)!]
        
        for item in self.tabBar.items! {
            if item.tag == selectedItem {
                item.setTitleTextAttributes(attributesSelected as [String: AnyObject]?, for: .normal)
                item.setTitleTextAttributes(attributesSelected as [String: AnyObject]?, for: .selected)
            } else {
                item.setTitleTextAttributes(attributesUnselected as [String: AnyObject]?, for: .normal)
                item.setTitleTextAttributes(attributesSelected as [String: AnyObject]?, for: .selected)
            }
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // To display a different font for selected and un selected tab bar item
        // Didn't work while setting normal and selected states
        // Reset font on each tab bar item
        
        selectedItem = item.tag
        configureItemFonts()
    }
    
    

    
}
