//
//  StudentLocation.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit
import MapKit

struct StudentLocation {
    
    var firstName = ""
    var lastName = ""
    var mapString = ""
    var mediaURL = ""
    var objectId = ""
    var uniqueKey = ""
    var latitude = 0.0
    var longitude = 0.0
    var createdAt = ""
    var updatedAt = ""
    
//    static let sharedInstance = StudentLocation()
//
//    var studentArray = [StudentLocation]()
    
    static var studentLocations = [StudentLocation]()
    
    // MARK: Initializers
    
    // Create StudentLocation from a dictionary
    init(dictionary: [String: AnyObject]) {
        
        objectId = dictionary[OnTheMapClient.JSONResponseKeys.objectId] as! String
        uniqueKey = dictionary[OnTheMapClient.JSONResponseKeys.uniqueKey] as! String
        firstName = dictionary[OnTheMapClient.JSONResponseKeys.firstName] as! String
        lastName = dictionary[OnTheMapClient.JSONResponseKeys.lastName] as! String
        mapString = dictionary[OnTheMapClient.JSONResponseKeys.mapString] as! String
        mediaURL = dictionary[OnTheMapClient.JSONResponseKeys.mediaURL] as! String
        latitude = dictionary[OnTheMapClient.JSONResponseKeys.latitude] as! Double
        longitude = dictionary[OnTheMapClient.JSONResponseKeys.longitude] as! Double
        createdAt = dictionary[OnTheMapClient.JSONResponseKeys.createdAt] as! String
        updatedAt = dictionary[OnTheMapClient.JSONResponseKeys.updatedAt] as! String
        
    }
    
//    init() {
//        
//        objectId = nil
//        uniqueKey = nil
//        firstName = nil
//        lastName = nil
//        mapString = nil
//        mediaURL = nil
//        latitude = nil
//        longitude = nil
//        createdAt = nil
//        updatedAt = nil
//        
//    }
    
    // Helper function to take array of dictionaries and convert to array of StudentLocation objects
//    static func arrayFromResults(results: [[String: AnyObject]]) -> [StudentLocation] {
//        
//        var studentLocations = [StudentLocation]()
//        for result in results {
//            studentLocations.append(StudentLocation(dictionary: result))
//        }
//        
//        return studentLocations
//        
//    }
    
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
}