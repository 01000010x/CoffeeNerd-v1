//
//  CoffeeListDataSourceController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/2/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoffeeListDataSource: NSObject, UITableViewDataSource {
    
    private let tableView: UITableView
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchedResultsController: CoffeeFetchedResultsController = {
        let controller = CoffeeFetchedResultsController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        return controller
    }()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    // MARK: Table View Data Source Protocol
    func object(atIndexPath indexPath: IndexPath) -> CoffeeBean{
        return fetchedResultsController.object(at: indexPath)
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! CustomCell
        cell.name.text = "Essai"
        
        //return configureCell(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    
    // MARK: Internal Functions
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let coffeeBean = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = coffeeBean.name
        return cell
    }
    
    func whichCoffeeBean(atIndexPath indexPath: IndexPath) -> CoffeeBean {
        return fetchedResultsController.object(at: indexPath)
    }
}
