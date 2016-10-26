//
//  CustomCell.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class represent a cell that display a CoffeeBean in the CoffeeBean List presented by the CoffeeListViewController
// This cell is expandable when selected
// When the user select a cell (ie: a CoffeeBean) the cell just exoand and present the BrewSetting list available (due to the settings chosen by the user)
// When the user then select one of these BrewSetting, we present a "card" displaying CoffeeBean attributes + the BrewType attributes associated with the
// BrewSetting name chosen
//
// -----------------------------------------------------------------------------------------------------

import UIKit

class CustomCell: UITableViewCell {

    // MARK: IBOutlet's
    
    @IBOutlet var name: UILabel!
    @IBOutlet var origin: UILabel!
    
    // We created one button per BrewSetting possible in the Storyboard
    // A dynamic creation would be cleaner but it would consume more time to develop right now. Expandables cells are not simple, especially in a tabbar navigation context
    @IBOutlet var brewingButton1: UIButton!
    @IBOutlet var brewingButton2: UIButton!
    @IBOutlet var brewingButton3: UIButton!
    @IBOutlet var brewingButton4: UIButton!
    @IBOutlet var brewingButton5: UIButton!
    @IBOutlet var brewingButton6: UIButton!
    @IBOutlet var brewingButton7: UIButton!
    @IBOutlet var brewingButton8: UIButton!
    @IBOutlet var brewingButton9: UIButton!
    @IBOutlet var brewingButton10: UIButton!
    @IBOutlet var brewingButton11: UIButton!
    @IBOutlet var brewingButton12: UIButton!
    
    
    // MARK: Variables + Constants
    
    let brewSettingList = BrewSettingList.sharedInstance.settingsList
    
    var isObserving = false
    var isAppearanceConfig = false
    var brewingButtons = [UIButton]()
    
    // Class var indicates the default height (cell collapsed) and the expanded height (height for ONE BrewSetting when the cell expanded)
    class var defaultHeight: CGFloat { get { return 75.0 } }
    class var expandedHeight: CGFloat { get { return 42.0 } } // One size expand (use one size per brew settings to display)
    
    // NSAttributes that will be used to configure the buttons labels
    private let attributes = [
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName : UIFont(name: "Raleway-Regular", size: 14)!
    ]
    
    // MARK: UITableViewCell Functions
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isAppearanceConfig = false
    }
    
    // Configure the cell appearance (with everyButton appearance)
    // Initialize the cell properties aswell
    func configAppearance() {
        if !isAppearanceConfig {
            
            // Add every Button defined as IBOutlet in the brewingButtons array
            brewingButtons.append(brewingButton1)
            brewingButtons.append(brewingButton2)
            brewingButtons.append(brewingButton3)
            brewingButtons.append(brewingButton4)
            brewingButtons.append(brewingButton5)
            brewingButtons.append(brewingButton6)
            brewingButtons.append(brewingButton7)
            brewingButtons.append(brewingButton8)
            brewingButtons.append(brewingButton9)
            brewingButtons.append(brewingButton10)
            brewingButtons.append(brewingButton11)
            brewingButtons.append(brewingButton12)
            
            // Prevent the lack of synchronization between the available BrewSetting number and the button number (due to lack of dynamic button creation)
            guard brewSettingList.count == brewingButtons.count else {
                fatalError("brewing settings and buttons aren't synchronized, make it dynamic")
            }
            
            // For every BrewSetting that was selected by the user in the settings, configure a button
            var i = 0
            for brewingSetting in brewSettingList where brewingSetting.isPosessed == true {
               
                let attributedTitle = NSAttributedString(string:  brewingSetting.name, attributes:attributes)
                brewingButtons[i].setAttributedTitle(attributedTitle, for: .normal)
                brewingButtons[i].setImage(brewingSetting.iconSmall(), for: .normal)
                brewingButtons[i].isHidden = false
                i+=1
            }
            
            // Tell the cell class that it is already configured
            isAppearanceConfig = true
        }
    }

    // Return the Brewing Buttons array. For the UIViewController when it will need to assign actions to each buttons
    func returnButtonsArray() -> [UIButton] {
        for brewingButton in brewingButtons {
            print(brewingButton.titleLabel?.text)
        }
        
        return brewingButtons
    }
    
    // To deal with expanding / collapsing
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
        }
    }
    
    // To deal with expanding / collapsing
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    // To deal with expanding / collapsing
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    // Core Function of the expanding / collapsing cell
    func checkHeight() {
        var brewSettingsPosessedNumber = 0
        
        // Count BrewSettings posessed
        for brewSetting in brewSettingList where brewSetting.isPosessed {
            brewSettingsPosessedNumber+=1
        }
        
        // init all buttons to hidden = true
        for brewingButton in brewingButtons {
            brewingButton.isHidden = true
        }
        
        // Re init all buttons
        var i = 0
        
        guard brewSettingList.count == brewingButtons.count else {
            fatalError("brewing settings and buttons aren't synchronized, make it dynamic")
        }
        
        for brewingSetting in brewSettingList where brewingSetting.isPosessed == true {
            
            let attributedTitle = NSAttributedString(string:  brewingSetting.name, attributes:attributes)
            brewingButtons[i].setAttributedTitle(attributedTitle, for: .normal)
            brewingButtons[i].setImage(brewingSetting.iconSmall(), for: .normal)
            brewingButtons[i].isHidden = false
            i+=1
        }

        // hide or show depending on number of brewSettings
        if brewSettingsPosessedNumber >= 1 {
            for i in 0...(brewSettingsPosessedNumber - 1) {
                brewingButtons[i].isHidden = (frame.size.height == CustomCell.defaultHeight)
                brewingButtons[i].reloadInputViews()
            }
        }
    }
    
    func configureLabel(withLabel label: String) {
        self.name.text = label
    }
    
    func configureOrigin(withString origin: String) {
        self.origin.text = origin
    }
    
    func changeLabelFont() {
        let selectedNameAttribute = [NSForegroundColorAttributeName: UIColor.white,
                                             NSFontAttributeName : UIFont(name: "Raleway-Bold", size: 18)!]
        
        self.name.attributedText = NSAttributedString(string:  self.name.text!, attributes:selectedNameAttribute)
    }
    
}
