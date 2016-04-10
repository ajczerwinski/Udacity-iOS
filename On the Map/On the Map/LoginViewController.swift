//
//  LoginViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/29/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var studentUsername: UITextField!
    @IBOutlet weak var studentPassword: UITextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentUsername.delegate = self
        studentPassword.delegate = self
        
        setUIEnabled(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.text = ""
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        self.setUIEnabled(false)
        OnTheMapClient.sharedInstance().postSession(studentUsername.text!, password: studentPassword.text!) { (success, error) in
            if success == true {
                print("Yay successfully logged in!")
                dispatch_async(dispatch_get_main_queue(), {
                    self.completeLogin(OnTheMapClient.AuthService.Udacity)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    AlertConvenience.showAlert(self, error: error!)
                })
                self.setUIEnabled(true)
            }
        }
    }
    
    //
    func completeLogin(service: OnTheMapClient.AuthService) {
        
        studentUsername.text = ""
        studentPassword.text = ""
            
        OnTheMapClient.sharedInstance().authServiceUsed = service
        self.setUIEnabled(true)
        
        let resultVC = self.storyboard!.instantiateViewControllerWithIdentifier("StudentTabController") as! UITabBarController
        self.presentViewController(resultVC, animated: true, completion: nil)

    }
    
    // Load the Udacity sign up page in Safari if the user clicks the 'Sign Up' button
    @IBAction func signUpButtonPressed(sender: UIButton) {

        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
        
    }
}

// Disable/Enable the Text Fields and Login button so user can't click them while completion handlers
// are firing
extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool) {
        studentUsername.enabled = enabled
        studentPassword.enabled = enabled
        loginButtonUI.enabled = enabled
        
        if enabled {
            loginButtonUI.alpha = 1.0
        } else {
            loginButtonUI.alpha = 0.5
        }
    }
}