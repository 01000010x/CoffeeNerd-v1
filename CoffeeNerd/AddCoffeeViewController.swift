//
//  AddCoffeeViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/24/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit
import CoreData

class AddCoffeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables & Outlets Declaration
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var originTextField: UITextField!
    @IBOutlet var shopTextField: UITextField!
    @IBOutlet var caffeinatedSegmentedControl: UISegmentedControl!
    @IBOutlet var validateButton: UIButton!
    @IBOutlet var brewingTableView: UITableView!
    
    // Singleton of CoreData Stack
    var dataController = DataController.sharedInstance
    
    // Path to save users info. We use it to save and fetch the user settings
    let itemArchiveURL: NSURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("item.archive") as NSURL
    }()
    
    // Array of BrewType. It contains the BrewTypes for a single CoffeeBean
    var brewTypeList = [BrewType]()
    
    // Array of possible BrewSettings
    var settingsListPosessed: [BrewSetting] = []
    
    // Coffee Bean that will be created and set in this view Controller
    var coffeeBean: CoffeeBean?
    
    var alert:UIAlertController!
    
    // MARK: View Controller
    
   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureHeaderTextFields()
        loadSettings()
        brewingTableView.reloadData()
    }
    */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureHeaderTextFields()
        loadSettings()
        brewingTableView.reloadData()
        
        // Scroll to the top when user play with tab bar and goes again on that view
        brewingTableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let separatorColor = ProjectColors.SeparatorColor.Yellow
        let padding: CGFloat = nameTextField.frame.height / 4.0
        nameTextField.drawBottomLine(separatorColor, padding: padding)
        originTextField.drawBottomLine(separatorColor, padding: padding)
        shopTextField.drawBottomLine(separatorColor, padding: padding)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Table View DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! AddCoffeeCell
        print("index : \(indexPath.row)")
        let brewImage: UIImage = settingsListPosessed[(indexPath as NSIndexPath).row].iconNotSelected()
        cell.configureBrewingLabel(withText: settingsListPosessed[indexPath.row].name)
        cell.configureBrewingImage(withImage: brewImage)
        
        // Keep the right values in the textfields (due to cell reuse)
        configureCellTextFields(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    
    // MARK: Internal Functions
    
    func configureCellTextFields(cell: AddCoffeeCell, indexPath: IndexPath) {
        cell.groundTextField.text = brewTypeList[indexPath.row].groundSetting
        cell.groundTextField.tag = indexPath.row
        cell.groundTextField.addTarget(self, action: #selector(groundTextFieldDidChange), for: UIControlEvents.editingChanged)
        let weight: Int = Int(brewTypeList[indexPath.row].groundWeight)
        cell.weightTextField.text = String(weight)
        cell.weightTextField.tag = indexPath.row
        cell.weightTextField.addTarget(self, action: #selector(weightTextFieldDidChange), for: UIControlEvents.editingChanged)
    
    }
    
    
    func groundTextFieldDidChange(textField: UITextField) {
        if let grind = textField.text {
            brewTypeList[textField.tag].groundSetting = grind
        }
        
        print(brewTypeList[textField.tag].groundSetting)
    }
    
    
    func weightTextFieldDidChange(textField: UITextField) {
        if let weightString = textField.text, let weightInt = Int(weightString) {
            brewTypeList[textField.tag].groundWeight = Int32(weightInt)
        }
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
    
    
    // Will load the Brewing Method defined in the settings and create a BrewType for each.
    // A BrewType is the Brewing Method applied to a Coffee Bean, it will get properties like a grind setting, bean weight and brewing time.
    // A CoffeeBean can have multiple BrewType and one BrewType is unique and specific to one CoffeeBean
    func loadSettings() {
        // CoreData
        let managedContext = dataController.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: BrewType.identifier, in:managedContext)
        
        // User Info
        settingsListPosessed.removeAll()
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [BrewSetting] {
            brewTypeList.removeAll()
            
            for brewSetting in archivedItems where brewSetting.isPosessed {
                print("load : \(brewSetting.name)")
                settingsListPosessed.append(brewSetting)
                
                // Core Data : Create a Brewing Type per BrewSetting selected in the app Settings
                let newBrewingType = NSManagedObject(entity: entity!, insertInto: managedContext) as! BrewType
                newBrewingType.setValue(brewSetting.name, forKey: "brewingMethodName")
                newBrewingType.setValue("0", forKey: "groundSetting")
                newBrewingType.setValue(0, forKey: "groundWeight")
                newBrewingType.setValue(0, forKey: "brewingTime")
                brewTypeList.append(newBrewingType)
            }
        }
    }
    
    
   func saveCoffeeBeans() {
        // For Core Data
        let managedContext = dataController.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: CoffeeBean.identifier, in:managedContext)
        
        // Create a CoffeeBean in the context
        let newCoffeeBean = NSManagedObject(entity: entity!, insertInto: managedContext) as! CoffeeBean
        newCoffeeBean.setValue(nameTextField.text, forKey: "name")
        newCoffeeBean.setValue(originTextField.text, forKey: "origin")
        newCoffeeBean.setValue(shopTextField.text, forKey: "shop")
        newCoffeeBean.setValue(true, forKey: "isCaffeinated")
        
        // Link every BrewType to the CoffeeBean
        for brewType in brewTypeList {
            newCoffeeBean.addBrewTypeObject(brewType: brewType)
        }
        
        do {
            // Save the modifications on the context
            try managedContext.save()
            
            // Dismiss the view controller
            dismiss(animated: true, completion: nil)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
    
    
    func displaySuccessfulSaveMessage() {
        
        
        
    }
    
    // MARK: IBActions
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        saveCoffeeBeans()
        self.nameTextField.becomeFirstResponder()
        self.nameTextField.resignFirstResponder()
        showAlert()
        resetCollectionView()
        configureHeaderTextFields()
        loadSettings()
        brewingTableView.reloadData()
        
    }
    
    
    
    /*
    func fetchCoffeeBean() {
        let managedContext = dataController.managedObjectContext
        let fetchRequest = NSFetchRequest<CoffeeBean>(entityName: "CoffeeBean")
        // try let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CoffeeBean")
        
        do {
            let results = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            coffeeListFromDB = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    */
    
}
