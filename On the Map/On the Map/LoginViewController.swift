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

    }
    
    func taskForPOSTMethod(method: String, var parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
//        let url = "https://www.udacity.com/api/session"
        
        let request = NSMutableURLRequest(URL: NSURL(fileURLWithPath: "https://www.udacity.com/api/session"))
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("applicaiton/json", forHTTPHeaderField: "Content-Type")
        var httpBody = "{\"udacity\": {\"username\": \"\(studentUsername.text!)\", \"password\": \"\(studentPassword.text!)\"}}"
        print(httpBody)
        request.HTTPBody = httpBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        print(request.HTTPBody!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            func displayError(error: String, debugLabelText: String? = nil) {
                print(error)
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                    self.debugTextLabel.text = "Login Failed (Login Step)."
                }
            }
//
//            guard (error == nil) else {
//                displayError("There was an error with your request: \(error)")
//                return
//            }
//            
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
//
//            let parsedResult: AnyObject!
//            do {
//                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
//            } catch {
//                displayError("Could not parse the data as JSON: '\(data)'")
//                return
//            }
            if error != nil {
                return
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
            print(newData)
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
            } catch {
                print("Could not parse the data as JSON: '\(newData)'")
                return
            }
            print(parsedResult)
        }
        task.resume()
        return task
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
}