////
////  ParseClient.swift
////  On the Map
////
////  Created by Allen Czerwinski on 3/30/16.
////  Copyright © 2016 Allen Czerwinski. All rights reserved.
////
//
//import Foundation
//
//class ParseClient: NSObject {
//    
//    var session: NSURLSession
//    
//    var sessionID: String? = nil
//    var userID: String? = nil
//    var user: UdacityUser? = nil
//    
//    override init() {
//        session = NSURLSession.sharedSession()
//        super.init()
//    }
//
//    func taskForGETMethod(method: String, parameters: [String: AnyObject], substituteIntoParameters: Bool = false, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        var mutableParameters = parameters
//        if substituteIntoParameters {
//            mutableParameters = ParseClient.substituteKeyInParameters(mutableParameters, key: ParseURLKeys.UniqueKey, value: UdacityUser.sharedInstance().key!)
//        }
//        
//        let urlString = ParseAPIMethods.ParseBase + method + ParseClient.escapedParameters(mutableParameters)
//
//        let url = NSURL(string: urlString)!
//        let request = NSMutableURLRequest(URL: url)
//        request.addValue(ParseConstants.ParseID, forHTTPHeaderField: "X-Parse-Application-Id")
//        request.addValue(ParseConstants.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
//        
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//            }
//            
//            guard (error == nil) else {
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
//                sendError("No data was returned by the request")
//                return
//            }
//                      
//            ParseClient.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
//        }
//        
//        task.resume()
//        return task
//    }
//    
//    func taskForPOSTMethod(method: String, jsonBody: [String: AnyObject], completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        let urlString = ParseAPIMethods.ParseBase + method
//        let url = NSURL(string: urlString)!
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        request.addValue(ParseConstants.ParseID, forHTTPHeaderField: "X-Parse-Application-Id")
//        request.addValue(ParseConstants.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        do {
//            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonBody, options: .PrettyPrinted)
//            print("Request Body: \(jsonBody)")
//        }
//        
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//         
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
//            }
//            
//            guard (error == nil) else {
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
//                sendError("No data was returned by the request")
//                return
//            }
//            
//            ParseClient.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
//            
//        }
//        
//        task.resume()
//        return task
//    }
//    
//    func taskForPUTMethod(method: String, jsonBody: [String: AnyObject], completionHandlerForPUT: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        let urlString = ParseAPIMethods.ParseBase + method
//        let url = NSURL(string: urlString)!
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "PUT"
//        request.addValue(ParseConstants.ParseID, forHTTPHeaderField: "X-Parse-Application-Id")
//        request.addValue(ParseConstants.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        do {
//            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonBody, options: .PrettyPrinted)
//            print("Request Body:  \(jsonBody)")
//        }
//        
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForPUT(result: nil, error: NSError(domain: "taskForPUTMethod", code: 1, userInfo: userInfo))
//            }
//            
//            guard (error == nil) else {
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
//                sendError("No data was returned by the request")
//                return
//            }
//            
//            ParseClient.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPUT)
//            
//        }
//        
//        task.resume()
//        return task
//        
//    }
//    
//    class func buildJSONBodyFromUdacityUser() -> [String: AnyObject] {
//        
//        var jsonBody: [String: AnyObject] = [:]
//        if let value = UdacityUser.sharedInstance().studentLocation.uniqueKey {
//            jsonBody[ParseParameterKeys.UniqueKey] = value
//        } else {
//            return [:]
//        }
//        if let value = UdacityUser.sharedInstance().studentLocation.firstName {
//            jsonBody[ParseParameterKeys.FirstName] = value
//        } else {
//            return [:]
//        }
//        if let value = UdacityUser.sharedInstance().studentLocation.lastName {
//            jsonBody[ParseParameterKeys.LastName] = value
//        } else {
//            return [:]
//        }
//        if let value = UdacityUser.sharedInstance().studentLocation.mapString {
//            jsonBody[ParseParameterKeys.MapString] = value
//        } else {
//            return [:]
//        }
//        if let value = UdacityUser.sharedInstance().studentLocation.mediaURL {
//            jsonBody[ParseParameterKeys.MediaURL] = value
//        } else {
//            return [:]
//        }
//        if let value = UdacityUser.sharedInstance().studentLocation.latitude {
//            jsonBody[ParseParameterKeys.Latitude] = value
//        } else {
//            return [:]
//        }
//        if let value = UdacityUser.sharedInstance().studentLocation.longitude {
//            jsonBody[ParseParameterKeys.Longitude] = value
//        } else {
//            return [:]
//        }
//        return jsonBody
//    }
//    
//    class func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
//        if method.rangeOfString("{\(key)}") != nil {
//            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
//        } else {
//            return nil
//        }
//    }
//    
//    class func substituteKeyInParameters(parameters: [String: AnyObject], key: String, value: String) -> [String: AnyObject] {
//        var resultsObject: [String:AnyObject] = [:]
//        for (objectKey, objectValue) in parameters {
//            if let stringValue: String = (objectValue as? String) {
//                if stringValue.rangeOfString("{\(key)}") != nil {
//                    resultsObject[objectKey] = stringValue.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
//                } else {
//                    resultsObject[objectKey] = objectValue
//                }
//            } else {
//                resultsObject[objectKey] = objectValue
//            }
//        }
//        return resultsObject
//    }
//    // CHECK HERE
//    class func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
//        
//        var parsedResult: AnyObject!
//        do {
//            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
//        } catch {
//            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON: '\(data)'"]
//            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
//        }
//        
//        completionHandlerForConvertData(result: parsedResult, error: nil)
//        
//    }
//    
//    class func escapedParameters(parameters: [String: AnyObject]) -> String {
//        
//        var urlVars = [String]()
//        
//        for (key, value) in parameters {
//            let stringValue = "\(value)"
//            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
//            urlVars += [key + "=" + "\(escapedValue!)"]
//        }
//        
//        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
//        
//    }
//    
//    class func sharedInstance() -> ParseClient {
//        struct Singleton {
//            static var sharedInstance = ParseClient()
//        }
//        return Singleton.sharedInstance
//    }
//    
//}