//
//  OnTheMapConstants.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/7/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

extension OnTheMapClient {
    
    //  Authentication services (for implementing Facebook login later on)
    enum AuthService {
        case Udacity
        case Facebook
    }
    
    struct Constants {
        
        // Parse Authorization
        static let ParseId: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // Facebook Authorization
//        static let FBAppID: String = "365362206864879"
//        static let FBSuffix: String = "onthemap"
        
        // URLs
        static let UdacityBaseURL: String = "https://www.udacity.com/api/"
        static let ParseBaseURL: String = "https://api.parse.com/1/classes/"
        
    }
    
    struct Methods {
        
        // Udacity
        static let UdacityUserData = "users/{id}"
        static let UdacityPostSession = "session"
        static let UdacityDeleteSession = "session"
        
        // Parse
        static let ParseGetOrPostStudentLocation = "StudentLocation"
        
    }
    
    struct URLKeys {
        
        static let UserId = "id"
        
    }
    
    struct ParameterKeys {
        
        static let UserId = "id"
        static let Limit = "limit"
        static let Skip = "skip"
        static let Where = "where"
        static let Order = "order"
        
    }
    
    struct HeaderKeys {
        
        static let ParseAppId = "X-Parse-Application-Id"
        static let ParseRESTAPIKey = "X-Parse-REST-API-Key"
        
    }
    
    struct JSONBodyKeys {
        
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
    }
    
    struct JSONResponseKeys {
        
        // StudentLocation
        static let createdAt = "createdAt"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let objectId = "objectId"
        static let uniqueKey = "uniqueKey"
        static let updatedAt = "updatedAt"
        
    }
    
}