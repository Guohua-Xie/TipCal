//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Davis Xie on 12/08/15.
//  Copyright (c) 2015 Davis Xie. All rights reserved.
//

import UIKit
import Foundation




class ViewController: UIViewController {
    
    
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var customTipPercentageLabel: UILabel!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var customPeopleLabel: UILabel!
    @IBOutlet weak var customPeopleSlider: UISlider!
    @IBOutlet weak var inputTextField: UITextField!
    
    // NSDecimalNumber constants used in the calulateTip method
    let decimal100 = NSDecimalNumber(string: "100.0")
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.becomeFirstResponder()
 
        
        billLabel.text="$0.00"
        tipsLabel.text="$0.00"
        totalLabel.text="$0.00"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // called when the use edits the text in the inputTextField
    // or moves the customTipPercentageSlider's thumb
    // or moves the customPeopleSlider's thumb
    
    
    
    
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let inputString = inputTextField.text // get user input
        
        let tipSliderValue = NSDecimalNumber(integer: Int(customTipPercentageSlider.value))
        let peopleSliderValue = NSDecimalNumber(integer: Int(customPeopleSlider.value))
        let peopleSlideValue =  Int(customPeopleSlider.value)
        
        let customPercent = tipSliderValue / decimal100
        if sender is UISlider {
            
            
            customTipPercentageLabel.text = NSNumberFormatter.localizedStringFromNumber(customTipPercentageSlider.value, numberStyle: NSNumberFormatterStyle.NoStyle)
            
            customPeopleLabel.text = NSNumberFormatter.localizedStringFromNumber(peopleSliderValue, numberStyle: NSNumberFormatterStyle.NoStyle)
        }
        
        
        if !inputString.isEmpty {
            let bill = NSDecimalNumber(string: inputString) / decimal100
            
            if  sender is UITextField {
                billLabel.text = formatAsCurrency(bill)
                
            }
            
            let customTip = bill * customPercent
            tipsLabel.text = formatAsCurrency(customTip)
            let total = customTip+bill
            totalLabel.text = NSNumberFormatter.localizedStringFromNumber(total, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
            
            
            if peopleSlideValue > 1 {
                
                let customTip = bill * customPercent
                tipsLabel.text = formatAsCurrency(customTip)
                
                
                let total = (customTip+bill)
                let dividePeople = NSDecimalNumber(integer: Int(peopleSliderValue))
                
                
                let eachTotal = total.decimalNumberByDividingBy(dividePeople).decimalNumberByRoundingAccordingToBehavior(NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundUp, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
                totalLabel.text = formatAsCurrency(eachTotal)
            }
        }
            
            
        
        
        
    }
}





// convert a numeric value to localized currency string
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(
        number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

//    // overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}
//    // overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}
//    // overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}