////
////  ParseConvenience.swift
////  On the Map
////
////  Created by Allen Czerwinski on 3/30/16.
////  Copyright © 2016 Allen Czerwinski. All rights reserved.
////
//
//import Foundation
//
//extension ParseClient {
//    
//    func loadStudentLocations(completionHandler: (success: Bool, errorString: String?) -> Void) {
//        
//        self.getStudentLocations() { (success, errorString) in
//         
//            if success {
//                completionHandler(success: true, errorString: nil)
//            } else {
//                completionHandler(success: false, errorString: errorString)
//            }
//            
//        }
//    }
//    
//    // LOOK HERE APPEARS TO BE TASK FOR GET METHOD but seems to get through successfully
//    func getStudentLocations(completionHandlerForGET: (success: Bool, errorString: String?) -> Void) {
//        let parameters = [ParseParameterKeys.SortOrder: "-updatedAt"]
//        taskForGETMethod(ParseAPIMethods.GetStudentLocations, parameters: parameters) { (result, error) -> Void in
//        
//            if let error = error {
//                completionHandlerForGET(success: false, errorString: error.localizedDescription)
//            } else {
//                if let resultsObject = (result as? [String: AnyObject]) where resultsObject.indexForKey(ParseResponseKeys.Results) != nil {
//                    if let studentLocationArray = resultsObject[ParseResponseKeys.Results] as? [[String:AnyObject]] {
//                        StudentLocationCollection.sharedInstance().populateCollectionFromResults(true, results: studentLocationArray)
//                        print("Students Loaded: \(StudentLocationCollection.sharedInstance().collection.count)")
//                        completionHandlerForGET(success: true, errorString: nil)
//                    } else {
//                        completionHandlerForGET(success: false, errorString: "Error getting student locations")
//                    }
//                } else {
//                    completionHandlerForGET(success: false, errorString: "No student location details returned")
//                }
//            }
//        
//        }
//    }
//    
//    func getUserStudentLocations(completionHandlerForGET: (success: Bool, errorString: String?) -> Void) {
//        
//        let parameters = [ParseParameterKeys.WhereQuery: "{\"uniqueKey\":\"{uniqueKey}\"}"]
//        let method: String = ParseAPIMethods.GetUserStudentLocation
//        
//        taskForGETMethod(method, parameters: parameters, substituteIntoParameters: true) { (result, error) -> Void in
//            
//            if let error = error {
//                completionHandlerForGET(success: false, errorString: error.localizedDescription)
//            } else {
//                if let resultsObject = (result as? [String: AnyObject]) where resultsObject.indexForKey(ParseResponseKeys.Results) != nil {
//                    print("Results: \(resultsObject)")
//                    if let studentLocationArray = (resultsObject[ParseResponseKeys.Results] as? [[String:AnyObject]]) where studentLocationArray.count > 0 {
//                        if let studentObject:[String:AnyObject] = studentLocationArray[0] {
//                            if let objectID: String = studentObject[ParseResponseKeys.ObjectID] as? String {
//                                UdacityUser.sharedInstance().parseObjectID = objectID
//                                print("User objectID set to: \(objectID)")
//                                completionHandlerForGET(success: true, errorString: nil)
//                            } else {
//                                completionHandlerForGET(success: false, errorString: "No objectID found")
//                            }
//                        } else {
//                            completionHandlerForGET(success: false, errorString: "No student records found")
//                        }
//                    } else {
//                        completionHandlerForGET(success: false, errorString: "Error getting student location from query")
//                    }
//                } else {
//                    completionHandlerForGET(success: false, errorString: "No student location details returned")
//                }
//            }
//            
//        }
//    }
//    
//    func postStudentLocation(completionHandlerForPOST: (success: Bool, errorString: String?) -> Void) {
//        
//        let jsonBody: [String: AnyObject] = ParseClient.buildJSONBodyFromUdacityUser()
//        taskForPOSTMethod(ParseAPIMethods.PostStudentLocations, jsonBody: jsonBody) { (result, error) -> Void in
//            if let error = error {
//                completionHandlerForPOST(success: false, errorString: "Failed to POST student location: \(error.localizedDescription)")
//            } else {
//                if let resultsObject = (result as? [String: AnyObject]) {
//                    if let objectID = resultsObject[ParseResponseKeys.ObjectID] as? String {
//                        UdacityUser.sharedInstance().studentLocation.objectID = objectID
//                        completionHandlerForPOST(success: true, errorString: nil)
//                    } else {
//                        completionHandlerForPOST(success: false, errorString: "Error unpacking Student Location in POST")
//                    }
//                
//                } else {
//                    completionHandlerForPOST(success: false, errorString: "Failed to POST student location")
//                }
//            }
//        }
//    }
//    
//    func putStudentLocation(completionHandlerForPUT: (success: Bool, errorString: String?) -> Void) {
//        
//        var mutableMethod: String = ParseAPIMethods.PutUserStudentLocation
//        mutableMethod = UdacityClient.substituteKeyInMethod(mutableMethod, key: ParseClient.ParseURLKeys.ObjectID, value: String(UdacityUser.sharedInstance().parseObjectID!))!
//        let jsonBody: [String: AnyObject] = ParseClient.buildJSONBodyFromUdacityUser()
//        taskForPUTMethod(mutableMethod, jsonBody: jsonBody) { (result, error) -> Void in
//            if let error = error {
//                completionHandlerForPUT(success: false, errorString: "Student Location put failed: \(error.localizedDescription)")
//            } else {
//                if let resultsObject = (result as? [String: AnyObject]) {
//                    if let updatedAt = resultsObject[ParseResponseKeys.ResultsUpdatedAt] as? String {
//                        print("User location updated to : \(updatedAt)")
//                        completionHandlerForPUT(success: true, errorString: nil)
//                    } else {
//                        completionHandlerForPUT(success: false, errorString: "Error getting student location post response")
//                    }
//                } else {
//                    completionHandlerForPUT(success: false, errorString: "Student Location Post failed")
//                }
//            }
//        }
//        
//    }
//    
//}