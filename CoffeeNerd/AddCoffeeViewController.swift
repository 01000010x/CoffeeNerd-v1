//
//  AddCoffeeViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/24/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class AddCoffeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var originTextField: UITextField!
    @IBOutlet var shopTextField: UITextField!
    @IBOutlet var caffeinatedSegmentedControl: UISegmentedControl!
    @IBOutlet var validateButton: UIButton!
    
    let itemArchiveURL: NSURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("item.archive") as NSURL
    }()
    
    enum WeightUnit: String {
        case grams
        case ounces
    }
    
    var weightUnitSelected: String = WeightUnit.grams.rawValue
    var settingsList: [BrewSetting] = []
    var settingsListPosessed: [BrewSetting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderTextFields()
        loadSettings()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let separatorColor = ProjectColors.SeparatorColor.Yellow
        let padding: CGFloat = nameTextField.frame.height / 4.0
        nameTextField.drawBottomLine(separatorColor, padding: padding)
        originTextField.drawBottomLine(separatorColor, padding: padding)
        shopTextField.drawBottomLine(separatorColor, padding: padding)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingsListPosessed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! AddCoffeeCell
        let brewImage: UIImage = settingsListPosessed[(indexPath as NSIndexPath).row].iconNotSelected()
        cell.configureBrewingLabel(withText: settingsListPosessed[indexPath.row].name)
        cell.configureBrewingImage(withImage: brewImage)
        
        return cell
        
    }
    
    func configureHeaderTextFields() {
        let attributes = [
            NSForegroundColorAttributeName: ProjectColors.Brown.Faded,
            NSFontAttributeName : UIFont(name: "Raleway-LightItalic", size: 14)!
        ]
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "BOURBON JAUNE, MOKA SIDAMO, ...", attributes:attributes)
        originTextField.attributedPlaceholder = NSAttributedString(string: "BRAZIL, COLOMBIA, ...", attributes:attributes)
        shopTextField.attributedPlaceholder = NSAttributedString(string: "DEVOCION, BLIND BARBER, ...", attributes:attributes)
    }
    
    func loadSettings() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [BrewSetting] {
            settingsList = archivedItems
            
            for BrewSetting in settingsList where BrewSetting.isPosessed {
                settingsListPosessed.append(BrewSetting)
                print(BrewSetting.name)
            }
        }
        
        let defaults = UserDefaults.standard
        if let weightArchived = defaults.string(forKey: "weightSetting") {
            weightUnitSelected = weightArchived
        } else {
            weightUnitSelected = WeightUnit.grams.rawValue
        }
    }
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        
        
    }
}
