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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkHeight() {
        if frame.size.height < CustomCell.expandedHeight {
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
        } else {
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            button5.isHidden = false
            button6.isHidden = false
        }
    }
    
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true
        }
    }
    
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    
}
