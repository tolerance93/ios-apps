//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var moneyPerPerson: String?
    var tipPercentage: String?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        tenPctButton.isSelected = false
        zeroPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        var percent:Float = 0
        if zeroPctButton.isSelected {
            percent = 0
            tipPercentage = "0"
        } else if tenPctButton.isSelected {
            percent = 0.1
            tipPercentage = "10"
        } else {
            percent = 0.2
            tipPercentage = "20"
        }
        let total = Float(billTextField.text ?? "0") ?? 0
        let numOfPeople = Float(splitNumberLabel.text ?? "0") ?? 0
        let calculatedTotal = (total * (1.0 + percent)) / numOfPeople
        
        moneyPerPerson = String(format: "%.2f", calculatedTotal)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = moneyPerPerson
            destinationVC.numoberOfPeople = splitNumberLabel.text
            destinationVC.tipPercentage = tipPercentage
        }
    }
    
}

