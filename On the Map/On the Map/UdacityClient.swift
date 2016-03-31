//
//  UdacityClient.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/29/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class UdacityClient : NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = NSURLSession.sharedSession()
    
    var sessionID: String? = nil
    var accountKey: String? = nil
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    // POST Method
    
    
    
    // MARK: Singleton of Udacity class
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}

