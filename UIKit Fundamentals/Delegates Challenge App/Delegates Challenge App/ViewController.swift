//
//  ViewController.swift
//  Delegates Challenge App
//
//  Created by Allen Czerwinski on 3/4/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var editingSwitch: UISwitch!
    
    let zipCodeFieldDelegate = ZipCodeFieldDelegate()
    let cashTextFieldDelegate = CashTextFieldDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField1.delegate = self.zipCodeFieldDelegate
        self.textField2.delegate = self.cashTextFieldDelegate
        self.textField3.delegate = self
        
        self.editingSwitch.setOn(false, animated: false)
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return self.editingSwitch.on
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func toggleTextEditor(sender: UISwitch) {
        
        if !(sender).on {
            self.textField3.resignFirstResponder()
        }
        
    }
    


}

