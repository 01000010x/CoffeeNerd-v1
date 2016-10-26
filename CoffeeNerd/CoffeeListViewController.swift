//
//  CoffeeListViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit
import CoreData

class CoffeeListViewController: UIViewController, UITableViewDelegate, UISearchResultsUpdating {
    
    // MARK: Variables and IBOutlets
    
    @IBOutlet var tableListView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var beginContentOffset: CGPoint?
    
    lazy var dataSource: CoffeeListDataSource = {
        return CoffeeListDataSource(tableView: self.tableListView)
    }()
    
    var selectedIndexPath: IndexPath?
    var coffeeBean: CoffeeBean?
    let brewSettingList = BrewSettingList.sharedInstance.settingsList
    
    let searchController = UISearchController(searchResultsController: nil)
    let dataController = DataController.sharedInstance
    
    // MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableListView.dataSource = dataSource
        
        // Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        //searchBar = searchController.searchBar // Inverser ? Pas bon ?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = selectedIndexPath {
            let cell = self.tableListView.cellForRow(at: indexPath)
            (cell as! CustomCell).ignoreFrameChanges()
            selectedIndexPath = nil
            tableListView.reloadRows(at: [indexPath], with: .none)
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor.white
            cell?.backgroundView = selectedBackgroundView
        }

       tableListView.reloadData()
       
        /*if let indexPath = selectedIndexPath {
            let cell = tableListView.cellForRow(at: indexPath) as! CustomCell
            cell.ignoreFrameChanges();
            print("\(cell.name.text)")
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = ProjectColors.Blue.medium
            cell.backgroundView = selectedBackgroundView
            //
            
            //configureButtonsTarget(atIndexPath: indexPath)
        }*/
    }
    
    override func viewDidLayoutSubviews() {
        let newHeight: CGFloat = 40 //desired textField Height.
        for subView in searchBar.subviews
        {
            for subsubView in subView.subviews
            {
                if let textField = subsubView as? UITextField
                {
                    var currentTextFieldBounds = textField.bounds
                    currentTextFieldBounds.size.height = newHeight
                    textField.bounds = currentTextFieldBounds
                    textField.borderStyle = UITextBorderStyle.roundedRect
                }
            }
        }
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            var nbSettingsPosessed = 0
            for brewSetting in BrewSettingList.sharedInstance.settingsList where brewSetting.isPosessed == true {
                nbSettingsPosessed+=1
            }
            
            let customExpandedHeight = CGFloat(nbSettingsPosessed) * CustomCell.expandedHeight
            return (customExpandedHeight + CustomCell.defaultHeight)
        } else {
            return CustomCell.defaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CustomCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previousIndexPath = selectedIndexPath // if a cell was expanded
        
        if indexPath == selectedIndexPath { // case of a retap on same cell
            selectedIndexPath = nil
        } else { // case of tap on a new cell
            selectedIndexPath = indexPath
            // Retrieve the selected CoffeeBean from the data
            coffeeBean = dataSource.object(atIndexPath: indexPath)
        }
        
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath { // a cell was tapped
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath { // a cell has just been tapped that is not the previous
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.automatic)
            
            // a cell has just been tapped that is not the previous
            if let current = selectedIndexPath {
                // Configure the buttons action
                let selectedBackgroundView = UIView()
                selectedBackgroundView.backgroundColor = ProjectColors.Blue.medium
                let cell = tableView.cellForRow(at: indexPath) as! CustomCell
                cell.backgroundView = selectedBackgroundView
                cell.changeLabelFont()
                initBrewType()
                configureButtonsTarget(atIndexPath: current)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.white
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundView = selectedBackgroundView

    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CustomCell).watchFrameChanges()
        if selectedIndexPath == indexPath {
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = ProjectColors.Blue.medium
            let cellToModify = cell as! CustomCell
            cellToModify.backgroundView = selectedBackgroundView
            cellToModify.changeLabelFont()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CustomCell).ignoreFrameChanges()
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
            let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
                let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "AddCoffeeController") as! AddCoffeeViewController
                let selectedCoffeeBean = self.dataSource.object(atIndexPath: indexPath)
                destinationController.coffeeBean = selectedCoffeeBean
                self.present(destinationController, animated:true, completion: nil)
            }
        
            edit.backgroundColor = ProjectColors.Grey.Faded
            
            let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
                if let indexPath = self.selectedIndexPath {
                    let cell = self.tableListView.cellForRow(at: indexPath)
                    (cell as! CustomCell).ignoreFrameChanges()
                    self.selectedIndexPath = nil
                    self.tableListView.reloadRows(at: [indexPath], with: .automatic ) // test different kind of animation on phone
                }
                
                let selectedCoffeeBean = self.dataSource.object(atIndexPath: indexPath) as NSManagedObject
                self.dataSource.managedObjectContext.delete(selectedCoffeeBean)
                DataController.sharedInstance.saveContext()
                
            }
            
            delete.backgroundColor = UIColor.red
            
            return [edit, delete]
    }
    
    
    func buttonTapped(sender: UIButton!) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let coffeeDetailsVC = storyboard.instantiateViewController(withIdentifier: "CoffeeDetailsViewController") as! CoffeeDetailsViewController
        var brewType: BrewType? = nil
        var brewSettingToUse: BrewSetting? = nil
        
        if let coffeeBean = self.coffeeBean {
            coffeeDetailsVC.coffeeBean = coffeeBean;
        }
        
        if let buttonTitle = sender.titleLabel?.text {
            do {
                brewType = try coffeeBean?.brewType(withName: (buttonTitle))
                print("buttonTapped \(brewType?.brewingMethodName)")
            } catch is CoffeeError {
                print("oups")
            } catch {
                print("oups")
            }
            
            for brewSetting in brewSettingList where brewSetting.isPosessed {
                if brewSetting.name == buttonTitle {
                    brewSettingToUse = brewSetting
                }
            }
        }
        
        coffeeDetailsVC.brewType = brewType
        coffeeDetailsVC.brewSetting = brewSettingToUse
        
        coffeeDetailsVC.modalPresentationStyle = .overFullScreen
        self.present(coffeeDetailsVC, animated: true, completion: nil)
    }
    
    
    func configureButtonsTarget(atIndexPath indexPath: IndexPath) {
        let brewingButtons = (self.tableListView.cellForRow(at: indexPath) as! CustomCell).returnButtonsArray()
        
        // Add actions to the cell buttons
        for button in brewingButtons {
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    func initBrewType() {
        let managedContext = dataController.managedObjectContext
        for brewSetting in brewSettingList where brewSetting.isPosessed {
            
            do {
                _ = try coffeeBean?.brewType(withName: brewSetting.name)
            } catch is CoffeeError {
                let entity =  NSEntityDescription.entity(forEntityName: BrewType.identifier, in:managedContext)
                let newBrewingType = NSManagedObject(entity: entity!, insertInto: managedContext) as! BrewType
                newBrewingType.setValue(brewSetting.name, forKey: "brewingMethodName")
                newBrewingType.setValue("0", forKey: "groundSetting")
                newBrewingType.setValue(0, forKey: "groundWeight")
                newBrewingType.setValue(0, forKey: "brewingTimeMinutes")
                newBrewingType.setValue(0, forKey: "brewingTimeSeconds")
                coffeeBean?.addBrewTypeObject(brewType: newBrewingType)
                print("Init brewing type : \(newBrewingType.brewingMethodName)")

            } catch {
                print("oups")
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("search")
        /*
         // if search string is not blank
         if let searchText = searchController.searchBar.text {
         
         // form the search format
         let predicate = NSPredicate(format: "(name contains [cd] %@)", searchText)
         
         // add the search filter
         frc.fetchRequest.predicate = predicate
         }
         else {
         
         // reset to all patients if search string is blank
         frc = getFRC()
         }
         
         // reload the frc
         fetch(frc)
         
         // refresh the table view
         self.tableView.reloadData()
         */
        if let searchText = searchController.searchBar.text {
            print("Filter : \(searchText)")
        }
   
    }

}
