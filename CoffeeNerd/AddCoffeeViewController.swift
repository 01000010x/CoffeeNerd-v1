//
//  AddCoffeeViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/24/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit
import CoreData

class AddCoffeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: Variables & Outlets Declaration
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var originTextField: UITextField!
    @IBOutlet var shopTextField: UITextField!
    @IBOutlet var caffeinatedSegmentedControl: UISegmentedControl!
    @IBOutlet var validateButton: UIButton!
    @IBOutlet var brewingTableView: UITableView!
    @IBOutlet var tableView: UITableView!
    
    
    // Singleton of CoreData Stack
    var dataController = DataController.sharedInstance
    
    // Array of BrewType. It contains the BrewTypes for a single CoffeeBean
    var brewTypeList = [BrewType]()
    
    // Coffee Bean that will be created and set in this view Controller
    var coffeeBean: CoffeeBean?
    
    var alert:UIAlertController! // en global ?

    let brewSettingList = BrewSettingList.sharedInstance.settingsList
    
    var brewSettingListPosessed = [BrewSetting]()
    
    // MARK: View Controller

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureHeaderTextFields()
        loadSettings()
        brewingTableView.reloadData()
        
        // Scroll to the top when user play with tab bar and goes again on that view
        brewingTableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To dismiss the keyboard on drag
        tableView.keyboardDismissMode = .onDrag
        
        // Add done button to dismiss keyboard, on keyboard for each header textfields
        nameTextField.addDoneButtonOnKeyboard()
        originTextField.addDoneButtonOnKeyboard()
        shopTextField.addDoneButtonOnKeyboard()
        
        // Make that controller the header textfields delegate
        nameTextField.delegate = self
        originTextField.delegate = self
        shopTextField.delegate = self
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Create the properties for the line to draw under each header textfields (color and padding
        let separatorColor = ProjectColors.SeparatorColor.lightGrey
        let padding: CGFloat = nameTextField.frame.height / 4.0
        
        // Assign these properties to the func "drawBottomLine" from UIView+DrawBorders class extension
        nameTextField.drawBottomLine(separatorColor, padding: padding)
        originTextField.drawBottomLine(separatorColor, padding: padding)
        shopTextField.drawBottomLine(separatorColor, padding: padding)
    }
    
    
    // MARK: Table View DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewSettingListPosessed.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! AddCoffeeCell
        
        let brewSetting = brewSettingListPosessed[indexPath.row]
        let brewImage: UIImage = brewSetting.iconNotSelected()
        
        cell.configureBrewingLabel(withText: brewSettingListPosessed[indexPath.row].name)
        cell.configureBrewingImage(withImage: brewImage)
        //cell.configureBrewingTextFields()
        
        // Keep the right values in the textfields (mandatory due to cell reuse)
        configureCellTextFields(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // If brew setting at indexPath in brewSettingListPosessed = french or any dripper -> bigger size to display the timer textfields
        switch brewSettingListPosessed[indexPath.row].name {
            case "Espresso", "Cold Brew", "Moka Pot", "Vacuum":
            return AddCoffeeCell.defaultHeight
            
            default:
            return AddCoffeeCell.withTimerHeight
        }
    }
    
    
    // MARK: Internal Functions
    
    func configureCellTextFields(cell: AddCoffeeCell, indexPath: IndexPath) {
        if brewTypeList.count > indexPath.row  {
            let brewType = brewTypeList[indexPath.row]
            
            cell.groundTextField.tag = indexPath.row
            if brewType.groundSetting != "0" {
                cell.groundTextField.text = brewType.groundSetting
            } else {
                cell.groundTextField.text = ""
            }
            cell.groundTextField.addTarget(self, action: #selector(groundTextFieldDidChange), for: UIControlEvents.editingChanged)
            
            cell.weightTextField.tag = indexPath.row
            let weight: Int = Int(brewType.groundWeight)
            if weight > 0 {
                cell.weightTextField.text = String(weight)
            } else {
                cell.weightTextField.text = ""
            }
            cell.weightTextField.addTarget(self, action: #selector(weightTextFieldDidChange), for: UIControlEvents.editingChanged)
            
            cell.minutesTextField.tag = indexPath.row
            if brewType.brewingTimeMinutes > 0 {
                cell.minutesTextField.text = String(brewType.brewingTimeMinutes)
            } else {
                cell.minutesTextField.text = ""
            }
            cell.minutesTextField.addTarget(self, action: #selector(minutesTextFieldDidChange), for: UIControlEvents.editingChanged)
            
            cell.secondsTextField.tag = indexPath.row
            if brewType.brewingTimeSeconds > 0 {
                if brewType.brewingTimeSeconds < 10 {
                    cell.secondsTextField.text = "0\(String(brewType.brewingTimeSeconds))"
                } else {
                    cell.secondsTextField.text = String(brewType.brewingTimeSeconds)
                }
            } else {
                cell.secondsTextField.text = ""
            }
            cell.secondsTextField.addTarget(self, action: #selector(secondsTextFieldDidChange), for: UIControlEvents.editingChanged)
        }
    }
    
    
    func groundTextFieldDidChange(textField: UITextField) {
        if let grind = textField.text {
            brewTypeList[textField.tag].groundSetting = grind
        }
    }
    
    
    func weightTextFieldDidChange(textField: UITextField) {
        if let weightString = textField.text, let weightInt = Int(weightString) {
            brewTypeList[textField.tag].groundWeight = Int32(weightInt)
        }
    }
    
    
    func minutesTextFieldDidChange(textField: UITextField) {
        if let minutes = textField.text {
            if let minutesInt32 = Int32(minutes) {
                brewTypeList[textField.tag].brewingTimeMinutes = minutesInt32
            }
        }
    }
    
    
    func secondsTextFieldDidChange(textField: UITextField) {
        if let seconds = textField.text {
            if let secondsInt32 = Int32(seconds) {
                brewTypeList[textField.tag].brewingTimeSeconds = secondsInt32
            }
        }
    }

    
    func configureHeaderTextFields() {
        
        // Configure Placeholder
        let attributes = [
            NSForegroundColorAttributeName: ProjectColors.Grey.lightPlaceholder,
            NSFontAttributeName : UIFont(name: "Raleway-LightItalic", size: 14)!
        ]
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "BOURBON JAUNE, MOKA SIDAMO, ...", attributes:attributes)
        originTextField.attributedPlaceholder = NSAttributedString(string: "BRAZIL, COLOMBIA, ...", attributes:attributes)
        shopTextField.attributedPlaceholder = NSAttributedString(string: "DEVOCION, BLIND BARBER, ...", attributes:attributes)
        
        // Configure appearance (for normal state and initialize error state
        nameTextField.configureTextField(forState: "normal")
        originTextField.configureTextField(forState: "normal")
        shopTextField.configureTextField(forState: "normal")
        
        // If coffeeBean already exists -> Edit mode
        if let coffeeBean = self.coffeeBean {
            nameTextField.text = coffeeBean.name
            originTextField.text = coffeeBean.origin
            shopTextField.text = coffeeBean.shop
            if coffeeBean.isCaffeinated {
                caffeinatedSegmentedControl.selectedSegmentIndex = 0
            } else {
                caffeinatedSegmentedControl.selectedSegmentIndex = 1
            }
        }
    }
    
    
    // Will load the Brewing Methods defined in the settings and create a BrewType for each.
    // A BrewType is the Brewing Method applied to a Coffee Bean, it will get properties like a grind setting, bean weight and brewing time.
    // A CoffeeBean can have multiple BrewType and one BrewType is unique and specific to one CoffeeBean
    func loadSettings() {
        // User Info
        brewTypeList.removeAll()
        brewSettingListPosessed.removeAll()
        
        // Init Brew Setting Posessed
        for brewSetting in brewSettingList where brewSetting.isPosessed {
            brewSettingListPosessed.append(brewSetting)
        }
        
        if let coffeeBean = self.coffeeBean {
            // Edit mode, the coffeeBean exists, so we'll just have to get back its properties and update it in CoreData eventually
            
            for brewSetting in brewSettingListPosessed {
                // For each brewSetting the user choose in the settings, let's check if the corresponding BrewType exists or is to create
                do {
                    let brewType = try coffeeBean.brewType(withName: (brewSetting.name))
                    
                    // BrewType exists, add it to the list
                    brewTypeList.append(brewType)
                } catch is CoffeeError {
                    
                    // BrewType doesn't exist, let's create one and add it to the list
                    // CoreData
                    let managedContext = dataController.managedObjectContext
                    let entity =  NSEntityDescription.entity(forEntityName: BrewType.identifier, in:managedContext)
                    
                    // Create a new Brewing Type
                    let newBrewingType = NSManagedObject(entity: entity!, insertInto: managedContext) as! BrewType
                    newBrewingType.setValue(brewSetting.name, forKey: "brewingMethodName")
                    newBrewingType.setValue("0", forKey: "groundSetting")
                    newBrewingType.setValue(0, forKey: "groundWeight")
                    newBrewingType.setValue(0, forKey: "brewingTimeMinutes")
                    newBrewingType.setValue(0, forKey: "brewingTimeSeconds")
                    coffeeBean.addBrewTypeObject(brewType: newBrewingType)
                    brewTypeList.append(newBrewingType)
                } catch {
                    print("Unexpected error trying to retrieve BrewType")
                }
            }
        
        } else {
            // Creation mode. The coffeeBean doesn't exist, we'll have to create it and save it to CoreData
            
            // CoreData
            let managedContext = dataController.managedObjectContext
            let entity =  NSEntityDescription.entity(forEntityName: BrewType.identifier, in:managedContext)
            
            for brewSetting in brewSettingListPosessed {
                
                // Core Data : Create a Brewing Type per BrewSetting selected in the app Settings
                let newBrewingType = NSManagedObject(entity: entity!, insertInto: managedContext) as! BrewType
                newBrewingType.setValue(brewSetting.name, forKey: "brewingMethodName")
                newBrewingType.setValue("0", forKey: "groundSetting")
                newBrewingType.setValue(0, forKey: "groundWeight")
                newBrewingType.setValue(0, forKey: "brewingTimeMinutes")
                newBrewingType.setValue(0, forKey: "brewingTimeSeconds")
                brewTypeList.append(newBrewingType)
            }
        }
    }
    
    
   func saveCoffeeBeans() {
    // For Core Data
    let managedContext = dataController.managedObjectContext
    let entity =  NSEntityDescription.entity(forEntityName: CoffeeBean.identifier, in:managedContext)
    
    // Deal with edit mode
        if let coffeeBean = self.coffeeBean {
            // Save coffee bean modification
            do {
                // Save the modifications on the context
                if let name = nameTextField.text, name != coffeeBean.name {
                    coffeeBean.setValue(name, forKey: "name")
                }
                
                if let origin = originTextField.text, origin != coffeeBean.origin {
                    coffeeBean.setValue(origin, forKey: "origin")
                }
                
                if let shop = shopTextField.text, shop != coffeeBean.shop {
                    coffeeBean.setValue(shop, forKey: "shop")
                }
                
                if caffeinatedSegmentedControl.selectedSegmentIndex == 0 {
                    coffeeBean.setValue(true, forKey: "isCaffeinated")
                } else {
                    coffeeBean.setValue(false, forKey: "isCaffeinated")
                }
                
                try managedContext.save()
                self.coffeeBean = nil
                dismiss(animated: true, completion: nil)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        } else {
            // Create a CoffeeBean in the context
            let newCoffeeBean = NSManagedObject(entity: entity!, insertInto: managedContext) as! CoffeeBean
            newCoffeeBean.setValue(nameTextField.text, forKey: "name")
            newCoffeeBean.setValue(originTextField.text, forKey: "origin")
            newCoffeeBean.setValue(shopTextField.text, forKey: "shop")
            
            if caffeinatedSegmentedControl.selectedSegmentIndex == 0 {
                newCoffeeBean.setValue(true, forKey: "isCaffeinated")
            } else {
                newCoffeeBean.setValue(false, forKey: "isCaffeinated")
            }
            
            // Link every BrewType to the CoffeeBean
            for brewType in brewTypeList {
                newCoffeeBean.addBrewTypeObject(brewType: brewType)
            }
            
            do {
                // Save the modifications on the context
                try managedContext.save()
                
                // Clean after you - controller coffeeBean to nil
                coffeeBean = nil
                
                // Dismiss the view controller
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    
    
    }
    
    
    func resetCollectionView() {
        nameTextField.text = nil
        originTextField.text = nil
        shopTextField.text = nil
    }
    
    
    func showAlert() {
        self.alert = UIAlertController(title: nil, message: "Saving successful !", preferredStyle: UIAlertControllerStyle.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(AddCoffeeViewController.dismissAlert), userInfo: nil, repeats: false)
    }
    
    
    func dismissAlert(){
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: IBActions
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        // Display error state of textfield if it's empty
        if (nameTextField.text == "") {
            nameTextField.configureTextField(forState: "error")
        } else {
            nameTextField.configureTextField(forState: "normal")
        }
        
        if (originTextField.text == "") {
            originTextField.configureTextField(forState: "error")
        } else {
            originTextField.configureTextField(forState: "normal")
        }
        
        if (shopTextField.text == "") {
            shopTextField.configureTextField(forState: "error")
        } else {
            shopTextField.configureTextField(forState: "normal")
        }
        
        // Mandatory requirement completed (ie : textfields not empty in the header)
        if (nameTextField.text != "" && originTextField.text != "" && shopTextField.text != "") {
            saveCoffeeBeans()
            
            self.nameTextField.becomeFirstResponder()
            self.nameTextField.resignFirstResponder()
            
            showAlert()
            resetCollectionView()
            configureHeaderTextFields()
            loadSettings()
            brewingTableView.reloadData()
            nameTextField.configureTextField(forState: "normal")
            originTextField.configureTextField(forState: "normal")
            shopTextField.configureTextField(forState: "normal")
            brewingTableView.setContentOffset(CGPoint.zero, animated: true)
        } else {
            brewingTableView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        switch textField {
            case nameTextField:
                return newLength <= 40
            case originTextField, shopTextField:
                return newLength <= 30
            default: return true
        }
    }
    
    @IBAction func caffeinatedSwitch(_ sender: AnyObject) {
        print(sender.selectedSegmentIndex)
    }
}
