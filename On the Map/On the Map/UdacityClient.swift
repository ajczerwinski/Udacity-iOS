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
    func taskForPOSTMethod(method: String, jsonBody: [String:AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        let urlString = UdacityConstants.ApiMethods.UdacityBase + method
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonBody, options: .PrettyPrinted)
        } catch {
            print("Could not serialize json")
        }
//        let httpBody = NSJSONSerialization.dataWithJSONObject(jsonBody, options: NSJSONWritingOptions.PrettyPrinted)
        
//        "{\"udacity\": {\"username\": \"\(studentUsername.text!)\", \"password\": \"\(studentPassword.text!)\"}}"
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
         
            // TODO: Complete task
            
        }
        return task
    }
    
    
    // MARK: Singleton of Udacity class
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}

