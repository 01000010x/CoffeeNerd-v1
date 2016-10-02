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
    @IBOutlet var tableListView: UITableView!
    @IBOutlet var addCoffeeButton: UIButton!
    
    let textCellIdentifier = "coffeeCell"
        
    lazy var dataSource: CoffeeListDataSource = {
        return CoffeeListDataSource(tableView: self.tableListView)
    }()
    
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
        
        delete.backgroundColor = ProjectColors.Red
        
        return [edit, delete]
    }
    
    
    // MARK: FetchedResultsControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableListView.reloadData()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewSegue" {
            guard let destinationController = segue.destination as? CoffeeDetailsViewController, let indexPath = tableListView.indexPathForSelectedRow else { return }
            
            let coffeeBeanSelected = self.dataSource.object(atIndexPath: indexPath)
            destinationController.coffeeBean = coffeeBeanSelected
        }
    }
}
