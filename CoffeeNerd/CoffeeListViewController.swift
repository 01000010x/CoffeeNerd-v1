//
//  CoffeeListViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class CoffeeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableListView: UITableView!
    
    let textCellIdentifier = "customCell"
    var coffeeList: [Coffee]?
    var selectedIndexPath: NSIndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the nib containing the cell
        tableListView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        
        // Initialising the coffe list
        initCoffeeList()
        
        if let coffeeListProvided = coffeeList {
            for i in 0..<coffeeListProvided.count {
                print(i)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let coffeeListProvided = coffeeList {
            return coffeeListProvided.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        
        if let coffeeListProvided = coffeeList, let coffeeProvided: Coffee = coffeeListProvided[indexPath.row] {
            cell.name.text = coffeeProvided.name
            cell.country.text = coffeeProvided.country
        }
        
        return cell
    }
    
    func initCoffeeList() {
        // Acces base de donnees et remplir tableau avec une liste de cafés
        
        // temporaire, cafés en dur
        let coffeeOne = Coffee(name: "Moka Sidamo", country: "Colombie", shop: "brulerie de ternes", brewTypeArray: nil)
        let coffeeTwo = Coffee(name: "Guat middle", country: "Guatemala", shop: "brulerie de ternes", brewTypeArray: nil)
        let coffeeThree = Coffee(name: "Murasami", country: "Ethiopie", shop: "Escargot d'or", brewTypeArray: nil)
        let coffeeFour = Coffee(name: "Baby Honey", country: "Japon", shop: "Escargot d'or", brewTypeArray: nil)
        let coffeeFive = Coffee(name: "Geisha", country: "Brésil", shop: "Café Lanni", brewTypeArray: nil)
        
        coffeeList = [coffeeOne]
        coffeeList?.append(coffeeTwo)
        coffeeList?.append(coffeeThree)
        coffeeList?.append(coffeeFour)
        coffeeList?.append(coffeeFive)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths: [NSIndexPath] = []
        if let previous = previousIndexPath {
            indexPaths.append(previous)
        }
        
        if let current = selectedIndexPath {
            indexPaths.append(current)
        }
        if indexPaths.count > 0 {
            tableListView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomCell).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableListView.visibleCells as! [CustomCell] {
            cell.ignoreFrameChanges()
        }
    }
     
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return CustomCell.expandedHeight
        } else {
            return CustomCell.defaultHeight
        }
    }
}
