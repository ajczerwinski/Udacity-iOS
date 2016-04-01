//
//  ParseClient.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/30/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    var session = NSURLSession.sharedSession()
    
    var sessionID: String? = nil
    var userID: String? = nil
    var user: UdacityUser? = nil
    
    override init() {
        super.init()
    }
    
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}