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
    
    let textCellIdentifier = "coffeeCell"
    var coffeeList: [Coffee]?
    var selectedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the nib containing the cell
       // tableListView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let coffeeListProvided = coffeeList {
            return coffeeListProvided.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        if let coffeeListProvided = coffeeList {
            let coffeeProvided: Coffee = coffeeListProvided[(indexPath as NSIndexPath).row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths: [IndexPath] = []
        if let previous = previousIndexPath {
            indexPaths.append(previous)
        }
        
        if let current = selectedIndexPath {
            indexPaths.append(current)
        }
        if indexPaths.count > 0 {
            tableListView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        //changeCellBackgroundAtIndexPath(indexPath)
        return indexPath
    }
    
    func changeCellBackgroundAtIndexPath(_ indexPath: IndexPath) {
        let cell = tableListView.cellForRow(at: indexPath) as! CustomCell
        let cellBackgroundColor = UIColor(red: 81.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        cell.backgroundColor = cellBackgroundColor
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CustomCell).watchFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CustomCell).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return CustomCell.expandedHeight
        } else {
            return CustomCell.defaultHeight
        }
    }
}
