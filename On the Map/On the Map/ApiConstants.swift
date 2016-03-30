//
//  UdacityConstants.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

struct APIConstants {
    
    struct URLAPIMethods {
        static let UdacityAPIScheme = "https"
        static let UdacityAPIHost = "www.udacity.com"
        static let UdacityAPIPath = "/api/"
//        static let UdacityBase = "https://www.udacity.com/api/"
        static let SessionLogin = "session"
        static let ParseAPIScheme = "https"
        static let ParseAPIHost = "api.parse.com"
        static let ParseAPIPath = "/1/classes/"
//        static let ParseBase = "https://api.parse.com/1/classes/"
        static let StudentLocations = "StudentLocation"
        static let GetUserInfo = "users/"
    }
    
    struct UdacityParameterKeys {
        static let APIKey = "api_key"
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Username = "username"
        static let Password = "password"
    }
    
    struct ParseParameterKeys {
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct UdacityResponseKeys {
        static let StatusCode = "status_code"
        static let StatusMessage = "status_message"
        static let Account = "account"
        static let RegisteredStatus = "registered"
        static let RegisteredKey = "key"
        static let Session = "session"
        static let SessionID = "id"
        
    }
    
}


