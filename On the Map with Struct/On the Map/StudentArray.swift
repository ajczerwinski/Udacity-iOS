//
//  StudentArray.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/20/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class StudentArray {
    class var sharedInstance: StudentArray {
        struct Static {
            static var instance: StudentArray = StudentArray()
        }
        return Static.instance
    }
    var myArray: [StudentLocation] = [StudentLocation]()
    var studentLocation: StudentLocation!
    
//    static func arrayFromResults(results: [String: AnyObject], completion: (dictionaryResult: [StudentLocation]?, errorString: String?) -> Void) {
//        
//        var studentLocations = [StudentLocation]()
//        if let locations = results["results"] as? [[String: AnyObject]] {
//            for location in locations {
//                studentLocations.append(StudentLocation(dictionary: location))
//            }
//            
//            completion(dictionaryResult: studentLocations, errorString: nil)
//            
//        } else {
//            completion(dictionaryResult: nil, errorString: "Could not parse location data")
//        }
//        
//    }
    
    static func arrayFromResults(results: [[String: AnyObject]]) -> [StudentLocation] {
        
        var studentLocations = [StudentLocation]()
        for result in results {
            studentLocations.append(StudentLocation(dictionary: result))
        }
        
        return studentLocations
        
    }

}