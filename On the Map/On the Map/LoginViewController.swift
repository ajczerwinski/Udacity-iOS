//
//  LoginViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/29/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var studentUsername: UITextField!
    @IBOutlet weak var studentPassword: UITextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        setUIEnabled(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        if studentUsername.text!.isEmpty || studentPassword.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty"
        } else {
            setUIEnabled(false)
        }
        UdacityClient.sharedInstance().authenticateWithUserCredentials(studentUsername.text!, password: studentPassword.text!) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    self.displayError(errorString)
                }
            }
        }
    }
    
    private func completeLogin() {
        ParseClient.sharedInstance().loadStudentLocations() { (success, errorString) in
            if success {
                print("Successfully loaded student locations! \(StudentLocationCollection.sharedInstance().collection.count)")
                performUIUpdatesOnMain {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let resultVC = storyboard.instantiateViewControllerWithIdentifier("NavigationManagerController") as! UINavigationController
                    self.presentViewController(resultVC, animated: true, completion: nil)
                
                
                    
                }
                
            }
        }
        debugTextLabel.text = ""
//        let controller = storyboard!.instantiateViewControllerWithIdentifier("StudentTabController") as! UITabBarController
//        presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        UdacityClient.sharedInstance().loadUdacitySignUpPage()
    }
    
    
}



extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool) {
        studentUsername.enabled = enabled
        studentPassword.enabled = enabled
        loginButtonUI.enabled = enabled
        debugTextLabel.text = ""
        debugTextLabel.enabled = enabled
        
        if enabled {
            loginButtonUI.alpha = 1.0
        } else {
            loginButtonUI.alpha = 0.5
        }
    }
    
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
}