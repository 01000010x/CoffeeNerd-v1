//
//  AddCoffeeCell.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/26/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit

class AddCoffeeCell: UITableViewCell {

    @IBOutlet var brewingMethodImage: UIImageView!
    @IBOutlet var brewingMethodLabel: UILabel!
    @IBOutlet var brewingMethodContainerView: UIView!
    
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var groundTextField: UITextField! {
        willSet {
            print("WILL")
        }
        
        didSet {
            self.grind = groundTextField.text!
            print("set \(self.grind)")
        }
    }
    
    var weight: Int
    var grind: String
    
    required init?(coder aDecoder: NSCoder) {
        self.weight = 0
        self.grind = "0"
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureBrewingImage(withImage image: UIImage) {
        self.brewingMethodImage.image = image
    }
    
    func configureBrewingLabel(withText text: String) {
        setNeedsLayout()
        layoutIfNeeded()
        brewingMethodLabel.text = text
        let lineOneStartPoint = CGPoint(x: 0.0 , y: brewingMethodLabel.frame.size.height * 0.7)
        let lineOneEndPoint = CGPoint(x: brewingMethodLabel.frame.width * 0.2, y:brewingMethodLabel.frame.size.height * 0.7)
        let lineTwoStartPoint = CGPoint(x: brewingMethodLabel.frame.width , y: brewingMethodLabel.frame.size.height * 0.7)
        let lineTwoEndPoint = CGPoint(x: brewingMethodLabel.frame.width - brewingMethodLabel.frame.width * 0.2 , y: brewingMethodLabel.frame.size.height * 0.7)
        
        brewingMethodLabel.drawLine(lineOneStartPoint, end: lineOneEndPoint, color: ProjectColors.Brown.Dark)
        brewingMethodLabel.drawLine(lineTwoStartPoint, end: lineTwoEndPoint, color: ProjectColors.Brown.Dark)
    }
    
    /* func configureBrewingSettings(withCoffeeSettings coffeeSettings: CoffeeSettings) {
        
    }*/

}
