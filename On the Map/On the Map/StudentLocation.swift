//
//  StudentLocation.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

struct StudentLocation {
    
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var objectID: String?
    var uniqueKey: String?
    var latitude: Double?
    var longitude: Double?
    
    var createdAt: String?
    var updatedAt: String?
    
    var pinImage: UIImage?
    
    var fullName: String {
        get {
            let emptyString = ""
            return "\(firstName == nil ? emptyString: firstName!) \(lastName == nil ? emptyString: lastName!)".stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
    }
    
    init(firstName: String, lastName: String, pinImage: UIImage) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.pinImage = pinImage
        
    }
    
    init() {
        
    }
    
    init?(resultObject: [String: AnyObject]) {
        
        objectID = resultObject[ParseClient.ParseResponseKeys.ResultsObjectID] as? String
        uniqueKey = resultObject[ParseClient.ParseResponseKeys.ResultsUniqueKey] as? String
        firstName = resultObject[ParseClient.ParseResponseKeys.ResultsFirstName] as? String
        lastName = resultObject[ParseClient.ParseResponseKeys.ResultsLastName] as? String
        mapString = resultObject[ParseClient.ParseResponseKeys.ResultsMapString] as? String
        mediaURL = resultObject[ParseClient.ParseResponseKeys.ResultsMediaURL] as? String
        latitude = resultObject[ParseClient.ParseResponseKeys.ResultsLatitude] as? Double
        longitude = resultObject[ParseClient.ParseResponseKeys.ResultsLongitude] as? Double
        createdAt = resultObject[ParseClient.ParseResponseKeys.ResultsCreateAt] as? String
        updatedAt = resultObject[ParseClient.ParseResponseKeys.ResultsUpdatedAt] as? String
        
        // If data we need to display on UI isn't available, don't return the object
        if objectID == nil || uniqueKey == nil || latitude == nil || longitude == nil || firstName == nil {
            return nil
        }
        
    }
    
}
