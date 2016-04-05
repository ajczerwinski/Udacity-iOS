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
    
    func mapAnnotationPoint() -> MKPointAnnotation {
        
        let lat = CLLocationDegrees(latitude!)
        let long = CLLocationDegrees(longitude!)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        return annotation
        
    }
    
    func mapAnnotation() -> MKPointAnnotation {
        
        let annotation = self.mapAnnotationPoint()
        annotation.title = "\(firstName!) \(lastName!)"
        annotation.subtitle = mediaURL!
        return annotation
        
    }
    
    func daysSinceLastUpdated() -> Int? {
        
        if var dateString = updatedAt {
            
            dateString = dateString.stringByReplacingOccurrencesOfString("T", withString: " ")
            dateString = dateString.stringByReplacingOccurrencesOfString("Z", withString: "")
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            if let record = formatter.dateFromString(dateString) {
                return daysBetweenDates(record, endDate: NSDate())
            } else {
                return nil
            }
            
        }
        return nil
    }
    
    func daysBetweenDates(startDate: NSDate, endDate: NSDate) -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day], fromDate: startDate, toDate: endDate, options: [])
        return components.day
        
    }
    
}

class StudentLocationCollection {
    var collection: [StudentLocation] = []
    var annotations: [MKPointAnnotation] = []
    
    class func sharedInstance() -> StudentLocationCollection {
        struct Singleton {
            static var sharedArray = StudentLocationCollection()
        }
        return Singleton.sharedArray
    }
    
    func populateCollectionFromResults(clearFirst: Bool, results: [[String: AnyObject]]) -> Void {
        if clearFirst {
            collection.removeAll()
            annotations.removeAll()
        }
        for studentLocationObject in results {
            if let newStudentLocation = StudentLocation(resultObject: studentLocationObject as [String: AnyObject]) {
                collection.append(newStudentLocation)
            }
        }
        
        collection.sortInPlace {$0.updatedAt > $1.updatedAt}
        for location in collection {
            annotations.append(location.mapAnnotation())
        }
        
    }
    
}
