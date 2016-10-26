//
//  AddCoffeeCell.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 9/26/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
// This class represent a cell that display a BrewType Content in the AddCoffeeViewController
// It will display every mandatory UITextField required by the BrewType
// - Weight : for every BrewType
// - Grind : for every BrewType
// - Time (minutes + seconds) : for certain BrewType
// -----------------------------------------------------------------------------------------------------

import UIKit

class AddCoffeeCell: UITableViewCell, UITextFieldDelegate {

    // MARK: Variables + Constants
    
    var weight: Int
    var grind: String
    
    // class variables that stock the height of the cell
    // - defaultHeight : when there's NO time UITextField to display
    // - withTimerHeight : when there's time UITextField to display
    class var defaultHeight: CGFloat { get { return 210 } }
    class var withTimerHeight: CGFloat { get { return 340 } }
    
    
    // MARK: IBOutlet's
    
    @IBOutlet var brewingMethodImage: UIImageView!
    @IBOutlet var brewingMethodLabel: UILabel!
    @IBOutlet var brewingMethodContainerView: UIView!
    
    // UITextField's
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var groundTextField: UITextField!
    @IBOutlet var minutesTextField: UITextField!
    @IBOutlet var secondsTextField: UITextField!
    
    @IBOutlet var timeSeparatorLabel: UILabel!
    @IBOutlet var groupViewTime: UIView!
    @IBOutlet var brewingTimeTitleLabel: UILabel!
    
    
    // MARK: UITableViewCell Functions
    
    required init?(coder aDecoder: NSCoder) {
        weight = 0
        grind = "0"
        super.init(coder: aDecoder)
    }
    
    // MARK: UITextFieldDelegate Functions
    
    // Called when everytime a character is typed or delete in an UITextfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Variables that will indicate if 
        // - lenght is OK
        // - characters are OK (numbers only in our case)
        var lenghtOK = false
        var charactersOK = false
        
        // This chunk of code just block the paste of a too big chain of characters
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        // Define invalid characters - others than numbers
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        
        // Check if character in the replacementString parameter are all allowed
        charactersOK = string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        
        // Calculate the new lenght of the UITextField.text
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        // Check if lenght is ok depending on the UITextfield
        switch textField {
        case minutesTextField:
            lenghtOK = newLength <= 1
        case weightTextField, groundTextField, secondsTextField:
            lenghtOK = newLength <= 2
        default:
            lenghtOK = true
            charactersOK = true
        }
        
        // If lenght and characters are OK, then return true, else block the typing
        if lenghtOK && charactersOK {
            return true
        } else {
            return false
        }
    }

    
    // MARK: Internal Functions
    
    // Method that assign an UIImage as the image of the BrewSetting of the cell
    func configureBrewingImage(withImage image: UIImage) {
        self.brewingMethodImage.image = image
    }
    
    // Configure the Brewing name UILabel and decorative line appearance
    func configureBrewingLabel(withText text: String) {
        // To force autolayout to calculate every constraint (needed to get the correct frames size)
        setNeedsLayout()
        layoutIfNeeded()
        
        // Set the brewingMethodLabel.text with the BrewSetting name in parameter
        brewingMethodLabel.text = text
        
        // Draw the decorative lines around the brewingMethodLabel using the drawLine in the UIView+DrawLines class extension
        let lineOneStartPoint = CGPoint(x: 0.0 , y: brewingMethodLabel.frame.size.height * 0.7)
        let lineOneEndPoint = CGPoint(x: brewingMethodLabel.frame.width * 0.2, y:brewingMethodLabel.frame.size.height * 0.7)
        let lineTwoStartPoint = CGPoint(x: brewingMethodLabel.frame.width , y: brewingMethodLabel.frame.size.height * 0.7)
        let lineTwoEndPoint = CGPoint(x: brewingMethodLabel.frame.width - brewingMethodLabel.frame.width * 0.2 , y: brewingMethodLabel.frame.size.height * 0.7)
        
        brewingMethodLabel.drawLine(lineOneStartPoint, end: lineOneEndPoint, color: ProjectColors.Grey.deep)
        brewingMethodLabel.drawLine(lineTwoStartPoint, end: lineTwoEndPoint, color: ProjectColors.Grey.deep)
        
        // Add a done button to dismiss keyboard, on the keyboard. This function is defined in UITextField+DoneButtonKeyboard class extension
        weightTextField.addDoneButtonOnKeyboard()
        groundTextField.addDoneButtonOnKeyboard()
    }
    
    // Method that assign self as the UITextFieldDelegate
    func configureBrewingTextFields() {
        weightTextField.delegate = self
        groundTextField.delegate = self
        minutesTextField.delegate = self
        secondsTextField.delegate = self
    }
}
