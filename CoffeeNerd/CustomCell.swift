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
    @IBOutlet var country: UILabel!
    
    @IBOutlet var button1: UILabel!
    @IBOutlet var button2: UILabel!
    @IBOutlet var button3: UILabel!
    @IBOutlet var button4: UILabel!
    @IBOutlet var button5: UILabel!
    @IBOutlet var button6: UILabel!
    
    var isObserving = false
    
    class var defaultHeight: CGFloat { get { return 44.0 } }
    class var expandedHeight: CGFloat { get { return 200.0 } } // Define it on tap on the cell, it will depend on the number of brew method for each coffee
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkHeight() {
        if frame.size.height < CustomCell.expandedHeight {
            button1.hidden = true
            button2.hidden = true
            button3.hidden = true
            button4.hidden = true
            button5.hidden = true
            button6.hidden = true
        } else {
            button1.hidden = false
            button2.hidden = false
            button3.hidden = false
            button4.hidden = false
            button5.hidden = false
            button6.hidden = false
        }
    }
    
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true
        }
    }
    
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    
}
