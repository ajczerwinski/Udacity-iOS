//
//  UdacityClient.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/29/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class ApiClient : NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = NSURLSession.sharedSession()
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
}