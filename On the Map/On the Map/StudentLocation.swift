//
//  StudentLocation.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit
import MapKit

class StudentLocation: NSObject {
    
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var latitude: Double?
    var longitude: Double?
    
    var createdAt: String?
    var updatedAt: String?
    
    static let sharedInstance = StudentLocation()
    
    var studentArray = [StudentLocation]()
    
    // MARK: Initializers
    
    // Create StudentLocation from a dictionary
    init(dictionary: [String: AnyObject]) {
        
        objectId = dictionary[OnTheMapClient.JSONResponseKeys.objectId] as? String
        uniqueKey = dictionary[OnTheMapClient.JSONResponseKeys.uniqueKey] as? String
        firstName = dictionary[OnTheMapClient.JSONResponseKeys.firstName] as? String
        lastName = dictionary[OnTheMapClient.JSONResponseKeys.lastName] as? String
        mapString = dictionary[OnTheMapClient.JSONResponseKeys.mapString] as? String
        mediaURL = dictionary[OnTheMapClient.JSONResponseKeys.mediaURL] as? String
        latitude = dictionary[OnTheMapClient.JSONResponseKeys.latitude] as? Double
        longitude = dictionary[OnTheMapClient.JSONResponseKeys.longitude] as? Double
        createdAt = dictionary[OnTheMapClient.JSONResponseKeys.createdAt] as? String
        updatedAt = dictionary[OnTheMapClient.JSONResponseKeys.updatedAt] as? String
        
    }
    
    override init() {
        
        objectId = nil
        uniqueKey = nil
        firstName = nil
        lastName = nil
        mapString = nil
        mediaURL = nil
        latitude = nil
        longitude = nil
        createdAt = nil
        updatedAt = nil
        
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
//    func mapAnnotationPoint() -> MKPointAnnotation {
//        
//        let lat = CLLocationDegrees(latitude!)
//        let long = CLLocationDegrees(longitude!)
//        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        return annotation
//        
//    }
//    func mapAnnotation() -> MKPointAnnotation {
//        
//        let annotation = self.mapAnnotationPoint()
//        annotation.title = "\(firstName!) \(lastName!)"
//        annotation.subtitle = mediaURL!
//        return annotation
//        
//    }
//    
//    func daysSinceLastUpdated() -> Int? {
//        
//        if var dateString = updatedAt {
//            
//            dateString = dateString.stringByReplacingOccurrencesOfString("T", withString: " ")
//            dateString = dateString.stringByReplacingOccurrencesOfString("Z", withString: "")
//            let formatter = NSDateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
//            if let record = formatter.dateFromString(dateString) {
//                return daysBetweenDates(record, endDate: NSDate())
//            } else {
//                return nil
//            }
//            
//        }
//        return nil
//    }
//    
//}
//
//class StudentLocationCollection {
//    var collection: [StudentLocation] = []
//    var annotations: [MKPointAnnotation] = []
//    
//    class func sharedInstance() -> StudentLocationCollection {
//        struct Singleton {
//            static var sharedArray = StudentLocationCollection()
//        }
//        return Singleton.sharedArray
//    }
//    
//    func populateCollectionFromResults(clearFirst: Bool, results: [[String: AnyObject]]) -> Void {
//        if clearFirst {
//            collection.removeAll()
//            annotations.removeAll()
//        }
//        for studentLocationObject in results {
//            if let newStudentLocation = StudentLocation(dictionary: studentLocationObject as [String: AnyObject]) {
//                collection.append(newStudentLocation)
////                print(collection[0].firstName)
//            }
//        }
//        
//        collection.sortInPlace {$0.updatedAt > $1.updatedAt}
//        for location in collection {
//            annotations.append(location.mapAnnotation())
//        }
//        
//    }
//
