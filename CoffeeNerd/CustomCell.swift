//
//  CustomCell.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var name: UILabel!
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
    
    let brewSettingList = BrewSettingList.sharedInstance.settingsList
    
    var isObserving = false
    var isAppearanceConfig = false
    var brewingButtons = [UIButton]()
    
    class var defaultHeight: CGFloat { get { return 44.0 } }
    class var expandedHeight: CGFloat { get { return 35.0 } } // One size expand (use one size per brew settings to display
    
    private let attributes = [
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName : UIFont(name: "Raleway-Regular", size: 14)!
    ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isAppearanceConfig = false
    }
    
   func configAppearance() {
       // print("CONFIG")
        if !isAppearanceConfig {
            print("in Config Appearance")
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
           
            isAppearanceConfig = true
        }
    }

    
    func returnButtonsArray() -> [UIButton] {
        return brewingButtons
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
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
        
        // RE INIT ALL FUCKIN BUTTONS
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
    
}
