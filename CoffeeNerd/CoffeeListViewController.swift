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
    
    let textCellIdentifier = "coffeeCell"
        
    lazy var dataSource: CoffeeListDataSource = {
        return CoffeeListDataSource(tableView: self.tableListView)
    }()
    
    var selectedIndexPath: IndexPath?
    
    var coffeeBean: CoffeeBean?
    var brewTypes = [BrewType]()
    
    
    // MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableListView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            let brewTypeNumber = brewTypes.count
            print("typeNum : \(brewTypeNumber)")
            return (CustomCell.expandedHeight * 2) + CustomCell.defaultHeight
        } else {
            return CustomCell.defaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
            
            // Retrieve the selected CoffeeBean from the data
            coffeeBean = dataSource.whichCoffeeBean(atIndexPath: indexPath)
            brewTypes.removeAll()
            for brewType in (coffeeBean?.brewTypes)! {
                brewTypes.append(brewType as! BrewType)
                print("Brew Type : \(brewTypes[indexPath.row].brewingMethodName)")
            }
        }
        
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.automatic)
        }
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
}
