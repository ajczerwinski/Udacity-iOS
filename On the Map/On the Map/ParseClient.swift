//
//  ParseClient.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/30/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    var session: NSURLSession
    
    var sessionID: String? = nil
    var userID: String? = nil
    var user: UdacityUser? = nil
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }

    func taskForGETMethod(method: String, var parameters: [String: AnyObject], jsonBody: String, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        parameters[ParseURLKeys.UniqueKey] = ParseConstants.APIKey
        
        let request = NSMutableURLRequest(URL: escapedParameters(parameters, withPathExtension: method))
        request.HTTPMethod = "GET"
        request.addValue(ParseConstants.ParseID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }
                      
            ParseClient.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        return task
    }
    
    class func substituteKeyInParameters(parameters: [String: AnyObject], key: String, value: String) -> [String: AnyObject] {
        var resultsObject: [String:AnyObject] = [:]
        for (objectKey, objectValue) in parameters {
            if let stringValue: String = (objectValue as? String) {
                if stringValue.rangeOfString("{\(key)}") != nil {
                    resultsObject[objectKey] = stringValue.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
                } else {
                    resultsObject[objectKey] = objectValue
                }
            } else {
                resultsObject[objectKey] = objectValue
            }
        }
        return resultsObject
    }
    
    class func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
        
    }
    
    private func escapedParameters(parameters: [String: AnyObject], withPathExtension: String? = nil) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = ParseAPIMethods.ParseScheme
        components.host = ParseAPIMethods.ParseHost
        components.path = ParseAPIMethods.ParsePath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
        
    }
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}