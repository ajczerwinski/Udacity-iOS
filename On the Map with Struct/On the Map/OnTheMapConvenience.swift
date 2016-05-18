//
//  OnTheMapConvenience.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/7/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

extension OnTheMapClient {
    
    // MARK: Create a Udacity session with POST
    func postSession(username: String, password: String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        // 1. Specify parameters, method, and HTTPBody.
        let method: String = Methods.UdacityPostSession
        let jsonBody: [String:AnyObject] = [
            OnTheMapClient.JSONBodyKeys.Udacity: [
                OnTheMapClient.JSONBodyKeys.Username: "\(username)",
                OnTheMapClient.JSONBodyKeys.Password: "\(password)"
            ]
        ]
        
        // 2. Make the request
        taskForPOSTMethod(method, baseURL: OnTheMapClient.Constants.UdacityBaseURL, headers: nil, jsonBody: jsonBody) { JSONResult, error in
            
            // 3. Send result (if successful) to the completion handler
            if let error = error {
                print("Unsuccessful posting Session")
                completionHandler(success: false, error: error)
            } else {
                if let results = JSONResult["account"] as? [String: AnyObject] {
                    OnTheMapClient.sharedInstance().authServiceUsed = OnTheMapClient.AuthService.Udacity
//                    studentLocations.uniqueKey 
                    let studentData: [String: AnyObject] = [
                        "username": "user@example.com",
                        "password": "password"
                    ]
                    StudentArray.sharedInstance.studentLocation = StudentLocation(dictionary: studentData)
                    StudentArray.sharedInstance.studentLocation.uniqueKey = results["key"] as! String
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "Client Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postSession data"]))
                }
            }
        }
    }
    
    // MARK: DELETE a Udacity Session (e.g. Log out)
    func deleteSession(completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        // 1. Specify parameters, method, and HTTP Body
        let method: String = Methods.UdacityDeleteSession

        // 2. Make the request
        taskForDELETEMethod(method) { result, error in
            
            // 3. Send value to the completion handler
            if let error = error {
                print("Unsuccessful Delete")
                completionHandler(success: false, error: error)
            } else {
                if let results = result["session"]!!["id"] as? String {
                    OnTheMapClient.sharedInstance().authServiceUsed = nil
                    OnTheMapClient.sharedInstance().sessionId = nil
                    print("Session deleted for ID: \(results)")
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "Client Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse deleteSession data"]))
                }
            }
        }
    }
    
    // MARK: GET Udacity Student Name
    // Pass firstName, lastName, and mediaURL as arguments in the completionHandler so they can
    // be updated in the struct object and accessible to the app
    func getStudentName(completionHandler: (success: Bool, error: NSError?, firstName: String?, lastName: String?, mediaURL: String?) -> Void) -> (Void) {
        
        // 1. Specify parameters, method, and HTTP Body
        let method: String
        
        let uniqueKey = StudentArray.sharedInstance.studentLocation.uniqueKey
        method = OnTheMapClient.substituteKeyInMethod(Methods.UdacityUserData, key: URLKeys.UserId, value: uniqueKey)!
        
        // Make the request
        taskForGETMethod(method, baseURL: OnTheMapClient.Constants.UdacityBaseURL, parameters: nil, headers: nil) { (result, error) in
            
            // 3. Send the value to the completion handler
            if let error = error {
                completionHandler(success: false, error: error, firstName: nil, lastName: nil, mediaURL: nil)
            } else {
                if let result = result["user"] as! [String: AnyObject]? {
                    // If there is a result, store it in first/last name of sharedInstance object
                    var studentLocation = StudentArray.sharedInstance.studentLocation
                    if let firstName = result["first_name"] {
                        print(firstName)
                        studentLocation.firstName = (firstName as? String)!
                    }
                    if let lastName = result["last_name"] {
                        print(lastName)
                        studentLocation.lastName = (lastName as? String)!
                    }
                    completionHandler(success: true, error: nil, firstName: nil, lastName: nil, mediaURL: nil)
                    if (studentLocation.firstName != "") && (studentLocation.lastName != "") {
                        // Pass studentLocation firstName, lastName, and mediaURL through if
                        // completionHandler is successful
                        completionHandler(success: true, error: nil, firstName: studentLocation.firstName, lastName: studentLocation.lastName, mediaURL: studentLocation.mediaURL)
                        print("Result from queryStudentName is: \(studentLocation.firstName) \(studentLocation.lastName)")
                    } else {
                        completionHandler(success: false, error: NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not get the user's name from the server"]), firstName: nil, lastName: nil, mediaURL: nil)
                    }
                } else {
                    completionHandler(success: false, error: NSError(domain: "Client Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to parse data in queryStudentName"]), firstName: nil, lastName: nil, mediaURL: nil)
                }
            }
        }
    }
    
    // GET student locations from Parse
    func getStudentLocations(completionHandler: (success: Bool, error: NSError?) -> Void) -> Void {
        
        // 1. Specify parameters, method, and HTTP Body, limit to 100 results, sort by last updated
        let parameters: [String: AnyObject] = [
            OnTheMapClient.ParameterKeys.Limit: Int(100),
            OnTheMapClient.ParameterKeys.Order: "-updatedAt"
        ]
        let method: String = Methods.ParseGetOrPostStudentLocation
        let headers: [String: String] = [
            OnTheMapClient.HeaderKeys.ParseAppId: OnTheMapClient.Constants.ParseId,
            OnTheMapClient.HeaderKeys.ParseRESTAPIKey: OnTheMapClient.Constants.APIKey
        ]
        
        // 2. Make the request
        taskForGETMethod(method, baseURL: OnTheMapClient.Constants.ParseBaseURL, parameters: parameters, headers: headers) { (result, error) in
            
            // 3. Send value to completion handler
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                // update the studentLocations array if there is valid user info
                if let results = result["results"] as? [[String: AnyObject]] {
                    let studentLocations = StudentArray.sharedInstance
                    studentLocations.myArray = StudentArray.arrayFromResults(results)
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "Client Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse data from getStudentLocations"]))
                }
            }
        }
    }
    
    // POST a StudentLocation from Parse
    func postStudentLocation(studentLocation: StudentLocation, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        // 1. Specify parameters, method, and HTTP Body
        let method: String = Methods.ParseGetOrPostStudentLocation
        let headers: [String: String] = [
            OnTheMapClient.HeaderKeys.ParseAppId: OnTheMapClient.Constants.ParseId,
            OnTheMapClient.HeaderKeys.ParseRESTAPIKey: OnTheMapClient.Constants.APIKey
        ]
        let jsonBody: [String: AnyObject] = [
            OnTheMapClient.JSONResponseKeys.uniqueKey: "\(studentLocation.uniqueKey)",
            OnTheMapClient.JSONResponseKeys.firstName: "\(studentLocation.firstName)",
            OnTheMapClient.JSONResponseKeys.lastName: "\(studentLocation.lastName)",
            OnTheMapClient.JSONResponseKeys.mapString: "\(studentLocation.mapString)",
            OnTheMapClient.JSONResponseKeys.mediaURL: "\(studentLocation.mediaURL)",
            OnTheMapClient.JSONResponseKeys.latitude: (studentLocation.latitude),
            OnTheMapClient.JSONResponseKeys.longitude: (studentLocation.longitude)
        ]
        
        // 2. Make the request
        taskForPOSTMethod(method, baseURL: OnTheMapClient.Constants.ParseBaseURL, headers: headers, jsonBody: jsonBody) { result, error in
            
            // Send value to completion handler
            if let error = error {
                print("Unsuccessful POST")
                completionHandler(success: false, error: error)
            } else {
                if result != nil {
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "Client Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not get student location data"]))
                }
            }
        }
    }
}