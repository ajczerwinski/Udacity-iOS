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
    
    var firstName: String = ""
    var lastName: String = ""
    var mapString: String = ""
    var mediaURL: String = ""
    var objectId: String = ""
    var uniqueKey: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var createdAt: String = ""
    var updatedAt: String = ""
    
    // MARK: Initializers
    
    // Create StudentLocation from a dictionary
    init(dictionary: [String: AnyObject]) {
        
        if let objectId = dictionary[OnTheMapClient.JSONResponseKeys.objectId] as? String {
            self.objectId = objectId
        }
        
        if let uniqueKey = dictionary[OnTheMapClient.JSONResponseKeys.uniqueKey] as? String {
            self.uniqueKey = uniqueKey
        }
        
        if let firstName = dictionary[OnTheMapClient.JSONResponseKeys.firstName] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictionary[OnTheMapClient.JSONResponseKeys.lastName] as? String {
            self.lastName = lastName
        }
        
        if let mapString = dictionary[OnTheMapClient.JSONResponseKeys.mapString] as? String {
            self.mapString = mapString
        }
        
        if let mediaURL = dictionary[OnTheMapClient.JSONResponseKeys.mediaURL] as? String {
            self.mediaURL = mediaURL
        }
        
        if let latitude = dictionary[OnTheMapClient.JSONResponseKeys.latitude] as? Double {
            self.latitude = latitude
        }
        
        if let longitude = dictionary[OnTheMapClient.JSONResponseKeys.longitude] as? Double {
            self.longitude = longitude
        }
        
        if let createdAt = dictionary[OnTheMapClient.JSONResponseKeys.createdAt] as? String {
            self.createdAt = createdAt
        }
        
        if let updatedAt = dictionary[OnTheMapClient.JSONResponseKeys.updatedAt] as? String {
            self.updatedAt = updatedAt
        }
    }
    
    // Helper function to take array of dictionaries and convert to array of StudentLocation objects
    static func arrayFromResults(results: [[String: AnyObject]]) -> [StudentLocation] {
        
        var studentLocations = [StudentLocation]()
        for result in results {
            studentLocations.append(StudentLocation(dictionary: result))
        }
        
        return studentLocations
        
    }
}