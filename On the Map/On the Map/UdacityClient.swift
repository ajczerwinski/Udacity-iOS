////
////  UdacityClient.swift
////  On the Map
////
////  Created by Allen Czerwinski on 3/29/16.
////  Copyright © 2016 Allen Czerwinski. All rights reserved.
////
//
//import Foundation
//
//class UdacityClient : NSObject {
//    
//    // MARK: Properties
//    
//    // shared session
//    var session: NSURLSession
//    
//    var sessionID: String? = nil
//    var accountKey: String? = nil
//    
//    // MARK: Initializers
//    override init() {
//        session = NSURLSession.sharedSession()
//        super.init()
//    }
//    
//    // POST Method
//    func taskForPOSTMethod(method: String, jsonBody: [String:AnyObject], completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        // 1/2. Set parameters and build url
//        let urlString = ApiMethods.UdacityBase + method
//        print(urlString)
//        let url = NSURL(string: urlString)!
//        print(url)
//        
//        // 3. Configure request
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // parse json if possible, if not print an error
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonBody, options: .PrettyPrinted)
//        } catch {
//            print("Could not serialize json")
//        }
//        
//        // 4. Make the request
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
//            }
//            
//            guard (error == nil ) else {
//                print("There was an error with your request: \(error)")
////                completionHandlerForPOST(result: nil, error: error)
//                return
//            }
//            
//            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
//                if let response = response as? NSHTTPURLResponse {
//                    print("Invalid statusCode response: \(response.statusCode)")
//                }
//                sendError("Your request returned a status code other than 2xx!")
//                return
//            }
//            
//            guard let data = data else {
//                sendError("No data was returned by the request!")
//                return
//            }
//            
//            let newData = UdacityClient.removeUdacityExtraCharactersFromData(data)
//            
//            // 5/6. Parse and use the data
//            UdacityClient.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
//        }
//        
//        // Start the request
//        task.resume()
//        return task
//    }
//    
//    func taskForGETMethod(method: String, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        // 1/2. Set parameters and build url
//        let urlString = ApiMethods.UdacityBase + method
//        let url = NSURL(string: urlString)!
//        
//        // 3. Configure request
//        let request = NSMutableURLRequest(URL: url)
//        
//        // 4. Make the request
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//        
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//            }
//            
//            guard (error == nil ) else {
//                sendError("There was an error with your request: \(error)")
//                return
//            }
//            
//            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
//                sendError("Your request returned a status code other than 2xx! \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                sendError("No data was returned by the request!")
//                return
//            }
//            
//            let newData = UdacityClient.removeUdacityExtraCharactersFromData(data)
//            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
//            
//            // 5/6. Parse and use the data
//            UdacityClient.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForGET)
//        }
//        
//        // Start the request
//        task.resume()
//        return task
//        
//    }
//    
//    func taskForDELETEMethod(method: String, completionHandlerForDELETE: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        // 1/2. Set parameters and build url
//        let urlString = ApiMethods.UdacityBase + method
//        let url = NSURL(string: urlString)!
//        
//        // 3. Configure request and manage the cookie
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "DELETE"
//        var xsrfCookie: NSHTTPCookie? = nil
//        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
//        
//        if let theCookies = sharedCookieStorage.cookies {
//            for cookie in theCookies {
//                if cookie.name == "XSRF-TOKEN" {
//                    xsrfCookie = cookie
//                }
//            }
//        }
//        
//        if let xsrfCookie = xsrfCookie {
//            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
//        }
//        
//        // 4. Make the request
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForDELETE(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//            }
//            
//            guard (error == nil ) else {
//                sendError("There was an error with your request: \(error)")
//                return
//            }
//            
//            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
//                sendError("Your request returned a status code other than 2xx!")
//                return
//            }
//            
//            guard let data = data else {
//                sendError("No data was returned by the request!")
//                return
//            }
//            
//            let newData = UdacityClient.removeUdacityExtraCharactersFromData(data)
//            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
//            
//            // 5/6. Parse and use the data
//            UdacityClient.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForDELETE)
//        }
//        
//        // Start the request
//        task.resume()
//        return task
//        
//    }
//    
//    class func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
//        
//        var parsedResult: AnyObject!
//        do {
//            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
//        } catch {
//            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
//            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
//        }
//        
//        completionHandlerForConvertData(result: parsedResult, error: nil)
//        
//    }
//    
//    class func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
//        
//        if method.rangeOfString("{\(key)}") != nil {
//            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
//        } else {
//            return nil
//        }
//        
//    }
//    
//    class func removeUdacityExtraCharactersFromData(data: NSData) -> NSData {
//        return data.subdataWithRange(NSMakeRange(5, data.length - 5))
//    }
//    
//    // MARK: Singleton of Udacity class
//    class func sharedInstance() -> UdacityClient {
//        struct Singleton {
//            static var sharedInstance = UdacityClient()
//        }
//        return Singleton.sharedInstance
//    }
//}
//
