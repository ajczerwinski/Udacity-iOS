//
//  CashTextFieldDelegate.swift
//  Delegates Challenge App
//
//  Created by Allen Czerwinski on 3/5/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

class CashTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        var newText = oldText.stringByReplacingCharactersInRange(range, withString: string)
        var newTextString = String(newText)
        
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var digitText = ""
        for char in newTextString.unicodeScalars {
            if digits.longCharacterIsMember(char.value) {
                digitText.append(char)
            }
        }
        
        if let numberOfPennies = Int(digitText) {
            newText = "$" + self.dollarStringFromInt(numberOfPennies) + "." + self.centsStringFromInt(numberOfPennies)
        } else {
            newText = "$0.00"
        }
        
        textField.text = newText
        
        return false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = "$0.00"
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func dollarStringFromInt(value: Int) -> String {
        return String(value / 100)
    }
    
    func centsStringFromInt(value: Int) -> String {
        
        let cents = value % 100
        var centsString = String(cents)
        
        if cents < 10 {
            centsString = "0" + centsString
        }
        
        return centsString
    }
    
}