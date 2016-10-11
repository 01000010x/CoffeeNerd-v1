//
//  CoffeeListViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit
import CoreData

class CoffeeListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: Variables and IBOutlets
    
    @IBOutlet var tableListView: UITableView!
    
    //let textCellIdentifier = "CoffeeCell"
    
    lazy var dataSource: CoffeeListDataSource = {
        return CoffeeListDataSource(tableView: self.tableListView)
    }()
    
    var selectedIndexPath: IndexPath?
    var coffeeBean: CoffeeBean?
    let brewSettingList = BrewSettingList.sharedInstance.settingsList
    
    
    // MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableListView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
       if let indexPath = selectedIndexPath {
            let cell = tableListView.cellForRow(at: indexPath) as! CustomCell
            cell.ignoreFrameChanges();
            tableListView.reloadRows(at: [indexPath], with: .automatic)
            configureButtonsTarget(atIndexPath: indexPath)
        }
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // print("height For Row at : \(indexPath.row)")
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
        //print("ESTIMATED height For Row at : \(indexPath.row)")
        return CustomCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //print("Did select Row : \(indexPath.row)")
        
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
                configureButtonsTarget(atIndexPath: current)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CustomCell).watchFrameChanges()
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
            let selectedCoffeeBean = self.dataSource.object(atIndexPath: indexPath) as NSManagedObject
            self.dataSource.managedObjectContext.delete(selectedCoffeeBean) // créer une méhode dans le data source nan ?
            DataController.sharedInstance.saveContext()
        }
        
        delete.backgroundColor = UIColor.red
        
        return [edit, delete]
    }
    
    
    // MARK: FetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableListView.reloadData()
    }
    
    
    func buttonTapped(sender: UIButton!) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let coffeeDetailsVC = storyboard.instantiateViewController(withIdentifier: "CoffeeDetailsViewController") as! CoffeeDetailsViewController
        
        if let coffeeBean = self.coffeeBean {
            coffeeDetailsVC.coffeeBean = coffeeBean;
        }
        
        if let buttonTitle = sender.title(for: .normal) {
            coffeeDetailsVC.brewSetting = BrewSetting(name: buttonTitle)
        }
        
        coffeeDetailsVC.modalPresentationStyle = .overCurrentContext
        
        present(coffeeDetailsVC, animated: true, completion: nil)
    }
    
    
    func configureButtonsTarget(atIndexPath indexPath: IndexPath) {
        let brewingButtons = (self.tableListView.cellForRow(at: indexPath) as! CustomCell).returnButtonsArray()
        
        // Add actions to the cell buttons
        for button in brewingButtons {
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        }
    }
}
