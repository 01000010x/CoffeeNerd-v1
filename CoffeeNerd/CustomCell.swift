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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isAppearanceConfig = false
       // print("init")
    }
    
   func configAppearance() {
       // print("CONFIG")
        if !isAppearanceConfig {
           // print("in Config Appearance")
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
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Raleway-Regular", size: 14)!
            ]
            
            var i = 0
            for brewingButton in brewingButtons {
                guard brewSettingList.count == brewingButtons.count else {
                    fatalError("brewing settings and buttons aren't synchronized, make it dynamic")
                }
                
                let attributedTitle = NSAttributedString(string: brewSettingList[i].name, attributes:attributes)
                brewingButton.setAttributedTitle(attributedTitle, for: .normal)
                brewingButton.setImage(brewSettingList[i].iconSelected(), for: .normal)
                brewingButton.isHidden = false
                i+=1
            }
           
            isAppearanceConfig = true
        }
    }

    
    func returnButtonsArray() -> [UIButton] {
        return brewingButtons
    }
    
    /*
    func displayButtons() {
        var i = 0
        for button in self.brewingButtons  {
            button.isHidden = false
            i+=1
        }
    }
    
    func hideButtons() {
        var i = 0
        for button in self.brewingButtons {
            button.isHidden = true
            i+=1
        }
    }
 */
    
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
        
        // hide or show depending on number of brewSettings
        for i in 0...(brewSettingsPosessedNumber - 1) {
            brewingButtons[i].isHidden = (frame.size.height == CustomCell.defaultHeight)
        }
    }
    
    func configureLabel(withLabel label: String) {
        self.name.text = label
    }
}
