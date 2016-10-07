//
//  CustomCell.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var name: UILabel!

    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    
    var isObserving = false
    
    class var defaultHeight: CGFloat { get { return 44.0 } }
    class var expandedHeight: CGFloat { get { return 40.0 } } // One size expand (use one size per brew settings to display
    
}
