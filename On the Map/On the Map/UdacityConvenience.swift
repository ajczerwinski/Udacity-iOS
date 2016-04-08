////
////  ApiConvenience.swift
////  On the Map
////
////  Created by Allen Czerwinski on 3/30/16.
////  Copyright © 2016 Allen Czerwinski. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//extension UdacityClient {
//    
//    func authenticateWithUserCredentials(username: String, password: String, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
//        
//        self.postSessionID(username, password: password) { (success, sessionID, errorString) in
//            
//            if success {
//                self.getUserInfo() {(success,result, errorString) in
//                    if success {
//                        print("Successfully logged in! \(result?.key) FirstName: \(result?.firstName) LastName: \(result?.lastName)")
//                        completionHandlerForAuth(success: true, errorString: nil)
//                    } else {
//                        completionHandlerForAuth(success: false, errorString: errorString)
//                    }
//                }
//            } else {
//                completionHandlerForAuth(success: false, errorString: errorString)
//            }
//        }
//    }
//    
//    func postSessionID(username: String, password: String, completionHandlerForAuth: (success: Bool, sessionID: String?, errorString: String?) -> Void) {
//        
//        let userObject: [String: AnyObject] = [UdacityParameterKeys.Username: username, UdacityParameterKeys.Password: password]
//        let jsonBody: [String: AnyObject] = ["udacity" : userObject]
//        
//        taskForPOSTMethod(ApiMethods.SessionLogin, jsonBody: jsonBody) { result, error in
//            
//            if let error = error {
//                print(error)
//                completionHandlerForAuth(success: false, sessionID: nil, errorString: "Connection Error in here yo, login error?")
//            } else {
//                if let accountObject = (result as! [String:AnyObject])[UdacityResponseKeys.Account] {
//                    if let isRegistered: Bool = accountObject[UdacityResponseKeys.RegisteredStatus] as? Bool {
//                        if isRegistered {
//                            if let userKey = accountObject[UdacityResponseKeys.RegisteredKey] {
//                                if let sessionObject = (result as! [String:AnyObject])[UdacityResponseKeys.Session] {
//                                    if let sessionID = sessionObject[UdacityResponseKeys.SessionID] {
//                                        self.accountKey = (userKey as! String)
//                                        self.sessionID = (sessionID as! String)
//                                        print("Yay we found the sessionID! \(self.sessionID)")
//                                        completionHandlerForAuth(success: true, sessionID: self.sessionID, errorString: nil)
//                                    } else {
//                                        let errorMessage = "Couldn't locate ID in the session results"
//                                        print(errorMessage)
//                                        completionHandlerForAuth(success: false, sessionID: nil, errorString: errorMessage)
//                                    }
//                                } else {
//                                    let errorMessage = "Couldn't locate session information in results"
//                                    print(errorMessage)
//                                    completionHandlerForAuth(success: false, sessionID: nil, errorString: errorMessage)
//                                }
//                            } else {
//                                let errorMessage = "Couldn't locate key in user results"
//                                print(errorMessage)
//                                completionHandlerForAuth(success: false, sessionID: nil, errorString: errorMessage)
//                            }
//                        } else {
//                            let errorMessage = "User is not registered"
//                            print(errorMessage)
//                            completionHandlerForAuth(success: false, sessionID: nil, errorString: errorMessage)
//                        }
//                    } else {
//                        let errorMessage = "Couldn't find user registration info in account results"
//                        print(errorMessage)
//                        completionHandlerForAuth(success: false, sessionID: nil, errorString: errorMessage)
//                    }
//                } else {
//                    let errorMessage = "Couldn't find account info in results"
//                    print(errorMessage)
//                    completionHandlerForAuth(success: false, sessionID: nil, errorString: errorMessage)
//                }
//            }
//        }
//    }
//    
//    func getUserInfo(completionHandler: (success: Bool, result: UdacityUser?, errorString: String?) -> Void) {
//        var mutableMethod: String = ApiMethods.GetUserInfo
//        mutableMethod = UdacityClient.substituteKeyInMethod(mutableMethod, key: UdacityClient.ApiMethods.UserID, value: String(UdacityClient.sharedInstance().accountKey!))!
//        taskForGETMethod(mutableMethod) { (result, error) -> Void in
//            if let error = error {
//                print(error)
//                completionHandler(success: false, result: nil, errorString: error.localizedDescription)
//            } else {
//                if let userObject = (result as? [String:AnyObject]) where userObject.indexForKey("user") != nil {
//                    let userDetail = userObject[UdacityResponseKeys.User] as! [String:AnyObject]
//                    UdacityUser.sharedInstance().setPropertiesFromResults(userDetail)
//                    print("Udacity User data has been loaded! Here is the key: \(UdacityUser.sharedInstance().key)")
//                    completionHandler(success: true, result: UdacityUser.sharedInstance(), errorString: nil)
//                } else {
//                    print("Udacity User data failed to load - No details returned")
//                    completionHandler(success: false, result: nil, errorString: "No details for user returned")
//                }
//            }
//        }
//    }
//    
//    // deleteSessionID method
//    func deleteSessionID(completionHandler: (success: Bool, errorString: String?) -> Void) {
//        
//        let method = ApiMethods.SessionDelete
//        taskForDELETEMethod(method) { (result, error) in
//            if let error = error {
//                print("Error in getUserInfo: \(error.localizedDescription)")
//                completionHandler(success: false, errorString: error.localizedDescription)
//            } else {
//                if let resultObject = (result as? [String: AnyObject]) where resultObject.indexForKey(UdacityResponseKeys.Session) != nil {
//                    if let sessionObject = resultObject[UdacityResponseKeys.Session] as? [String: AnyObject] {
//                        if let sessionID = sessionObject[UdacityResponseKeys.SessionID] as? String {
//                            print("Successfully logged out with Session ID: \(sessionID)")
//                            completionHandler(success: true, errorString: nil)
//                            return
//                        }
//                    }
//                }
//                print("Failed to log out of Udacity Session")
//                completionHandler(success: false, errorString: "Unable to delete Session ID")
//            }
//        }
//        
//    }
//    
//    // TODO: implement function to load Udacity sign up page
//    func loadUdacitySignUpPage() {
//        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
//    }
//
//}