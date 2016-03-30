//
//  UdacityConstants.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

struct ApiConstants {
    
    struct urlAPiMethods {
        static let UdacityBase = "https://www.udacity.com/api/"
        static let SessionLogin = "session"
        static let ParseBase = "https://api.parse.com/1/classes/"
        static let StudentLocations = "StudentLocation"
        static let GetUserInfo = "users/"
    }
    
    struct UdacityParameterKeys {
        static let ApiKey = "api_key"
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Username = "username"
        static let Password = "password"
    }
    
    struct ParseKeys {
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
}


