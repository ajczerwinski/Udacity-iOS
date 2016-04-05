//
//  ParseConvenience.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/30/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func loadStudentLocations(completionHandler: (success: Bool, errorString: String?) -> Void) {
        
        self.getStudentLocations() { (success, errorString) in
         
            if success {
                completionHandler(success: true, errorString: nil)
            } else {
                completionHandler(success: false, errorString: errorString)
            }
            
        }
    }
    
    func getStudentLocations(completionHandlerForGET: (success: Bool, errorString: String?) -> Void) {
        let parameters = [ParseParameterKeys.SortOrder: "-updatedAt"]
        taskForGETMethod(ParseAPIMethods.GetStudentLocations, parameters: parameters) { (result, error) -> Void in
        
            if let error = error {
                completionHandlerForGET(success: false, errorString: error.localizedDescription)
            } else {
                if let resultsObject = (result as? [String: AnyObject]) where resultsObject.indexForKey(ParseResponseKeys.Results) != nil {
                    if let studentLocationArray = resultsObject[ParseResponseKeys.Results] as? [[String:AnyObject]] {
                        StudentLocationCollection.sharedInstance().populateCollectionFromResults(true, results: studentLocationArray)
                        print("Students Loaded: \(StudentLocationCollection.sharedInstance().collection.count)")
                        completionHandlerForGET(success: true, errorString: nil)
                    } else {
                        completionHandlerForGET(success: false, errorString: "Error getting student locations")
                    }
                } else {
                    completionHandlerForGET(success: false, errorString: "No student location details returned")
                }
            }
        
        }
    }
    
    
}