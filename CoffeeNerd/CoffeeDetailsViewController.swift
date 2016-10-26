//
//  CoffeeDetailsViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 8/30/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class CoffeeDetailsViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    // MARK: Variables and Outlets
    
    @IBOutlet var containerBottomView: UIView!
    @IBOutlet var coffeeNameLabel: UILabel!
    @IBOutlet var coffeeOriginLabel: UILabel!
    @IBOutlet var coffeeShopLabel: UILabel!
    @IBOutlet var brewTypeNameLabel: UILabel!
    @IBOutlet var brewTypeIcon: UIImageView!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var grindTextField: UITextField!
    @IBOutlet var timerButton: UIButton!
    @IBOutlet var popupView: UIView!
    @IBOutlet var decafIcon: UIImageView!
    @IBOutlet var decafLabel: UILabel!
    
    var coffeeBean: CoffeeBean?
    var brewType: BrewType?
    var brewSetting: BrewSetting?
    
    // Singleton of CoreData Stack
    var dataController = DataController.sharedInstance
    
    // MARK: View Controller
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initInterface()
        initTextLabels()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBlurView()
        weightTextField.addDoneButtonOnKeyboard()
        grindTextField.addDoneButtonOnKeyboard()
        
        weightTextField.delegate = self
        grindTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
       
        self.popupView.drawRoundedCornerView(corners: .allCorners)
        if containerBottomView.frame.size.width < 900 {
            let center = CGPoint.init(x: containerBottomView.frame.size.width * 0.85, y: containerBottomView.frame.size.height * 0.85)
            let radius = containerBottomView.frame.size.width * 0.85
            let colors = [ProjectColors.Blue.radialStart.cgColor, ProjectColors.Blue.radialEnd.cgColor]
            
            let gradientLayer: RadialGradientLayer = RadialGradientLayer.init(center: center, radius: radius, colors: colors)
            gradientLayer.frame = containerBottomView.bounds
            containerBottomView.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Internal functions
    
    func initTextLabels() {
        guard brewType != nil else {
            fatalError("BrewType init failed - code issue")
        }
        
        if let grind = brewType?.groundSetting, grind != "0" {
            grindTextField.text = grind
        }
        
        if let weight = brewType?.groundWeight, weight > 0  {
            weightTextField.text = String(weight)
        }
        
        if let caffeinated = coffeeBean?.isCaffeinated, caffeinated == true {
            decafIcon.isHidden = true
            decafLabel.isHidden = true
        }
        
        coffeeNameLabel.text = coffeeBean?.name
        coffeeOriginLabel.text = coffeeBean?.origin.capitalized
        coffeeShopLabel.text = coffeeBean?.shop.capitalized
        brewTypeNameLabel.text = brewType?.brewingMethodName.capitalized
        brewTypeIcon.image = brewSetting?.iconSelected()
    }
    
    @IBAction func closeViewButtonTapped(_ sender: AnyObject) {
        saveCoffeeBeanUpdate()
        self.dismiss(animated: true, completion: {});
    }
    
    
    func saveCoffeeBeanUpdate() {
        
        let managedContext = dataController.managedObjectContext
        do {
            // Save the modifications on the context
            if let grind = grindTextField.text {
                brewType?.setValue(grind, forKey: "groundSetting")
            } else {
                brewType?.setValue("0", forKey: "groundSetting")
            }
            
            if let weight = Int(weightTextField.text!) {
                brewType?.setValue(weight, forKey: "groundWeight")
            } else {
                brewType?.setValue(0, forKey: "groundWeight")
            }
           
            try managedContext.save()
       
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func initInterface() {
        // Show the timer button on for the Brew Method that needs one
        if let brewMethod = brewSetting?.name {
            switch brewMethod {
            case "Bonmac", "V60", "Beehouse", "French Press", "Kalita Wave", "Chemex", "Aeropress", "Eva Solo":
                //Show button
                timerButton.isHidden = false
                break
            default:
                // Hide
                timerButton.isHidden = true
                break
            }
        }
       
    }
    
    func makeBlurView() {
        // Create a blur view
        let blurEffect = UIBlurEffect(style: .dark)
        
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(blurView, at: 0)
        
        // AutoLayout constraints for blured view size
        let blurViewHeight = NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: blurView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        let blurViewWidth = NSLayoutConstraint(item: self.view, attribute: .width, relatedBy: .equal, toItem: blurView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        // Apply AutoLayout constraints to the blured view
        self.view.addConstraints([blurViewWidth, blurViewHeight])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var lenghtOK = false
        var charactersOK = false
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        charactersOK = string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        switch textField {
        case weightTextField, grindTextField:
            lenghtOK = newLength <= 2
        default:
            lenghtOK = true
            charactersOK = true
        }
        
        if lenghtOK && charactersOK {
            return true
        } else {
            return false
        }
    }

    @IBAction func timerButtonTapped(_ sender: AnyObject) {
        saveCoffeeBeanUpdate()
    }
    
    
}
