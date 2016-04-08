////
////  UdacityUser.swift
////  On the Map
////
////  Created by Allen Czerwinski on 3/31/16.
////  Copyright © 2016 Allen Czerwinski. All rights reserved.
////
//
//import Foundation
//
//// Class to store Udacity User data
//class UdacityUser {
//    
//    var key: String? {
//        willSet(newKey) {
//            studentLocation.uniqueKey = newKey
//        }
//    }
//    
//    var firstName: String? {
//        willSet(newFirstName) {
//            studentLocation.firstName = newFirstName
//        }
//    }
//    
//    var lastName: String? {
//        willSet(newLastName) {
//            studentLocation.lastName = newLastName
//        }
//    }
//    
//    var studentLocation: StudentLocation {
//        didSet {
//            studentLocation.firstName = self.firstName
//            studentLocation.lastName = self.lastName
//            studentLocation.uniqueKey = self.key
//        }
//    }
//    
//    var parseObjectID: String?
//    
//    init() {
//        studentLocation = StudentLocation()
//    }
//    
//    func resetLocation() {
//        studentLocation = StudentLocation()
//    }
//    
//    func setPropertiesFromResults(dictionary: [String: AnyObject]) {
//        self.firstName = dictionary[UdacityClient.UdacityResponseKeys.UserFirstName] as? String
//        self.lastName = dictionary[UdacityClient.UdacityResponseKeys.UserLastName] as? String
//        self.key = dictionary[UdacityClient.UdacityResponseKeys.RegisteredKey] as? String
//        
//    }
//    
//    class func sharedInstance() -> UdacityUser {
//        
//        struct Singleton {
//            static var sharedInstance = UdacityUser()
//        }
//        
//        return Singleton.sharedInstance
//        
//    }
//    
//}