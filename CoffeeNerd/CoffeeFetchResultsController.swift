//
//  CoffeeFetchResultsController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoffeeFetchedResultsController: NSFetchedResultsController<CoffeeBean>, NSFetchedResultsControllerDelegate {
    
    private let tableView: UITableView
    
    var predicate = ""
    
    init(managedObjectContext: NSManagedObjectContext, withTableView tableView: UITableView) {
        self.tableView = tableView
        super.init(fetchRequest: CoffeeBean.fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        tryFetch()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print("Unresolved error : \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchRequestWithPredicate(predicate: NSPredicate) {
        
    }

    
    // MARK: FetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .move, .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
