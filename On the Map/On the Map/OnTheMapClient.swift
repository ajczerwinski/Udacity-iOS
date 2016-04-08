//
//  OnTheMapClient.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/7/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class OnTheMapClient: NSObject {
    
    //Shared session
    var session: NSURLSession
    
    var authServiceUsed: AuthService?
    
    var sessionId: String? = nil
    var userID: Int? = nil
    
    override init() {
        
        session = NSURLSession.sharedSession()
        super.init()
        
    }
    
    // GET Method
    func taskForGETMethod(method: String, baseURL: String, parameters: [String: AnyObject]?, headers: [String: String]?, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // 1/2/3. Set parameters, build and configure request
        var urlString: String
        if let parameters = parameters {
            urlString = baseURL + method + OnTheMapClient.escapedParameters(parameters)
        } else {
            urlString = baseURL + method
        }
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        if let headers = headers {
            for(key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // 4. Make the request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
         
            OnTheMapClient.manageErrors(data, response: response, error: error, completionHandler: completionHandler)
            
            // 5/6. Parse and use the data
            if let data = data {
                
                var newData: NSData
                // If the request is coming frmo Udacity, we need to strip the first 5 characters
                if method.containsString("users") {
                    newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                    // if the data is not coming from Udacity, don't strip first 5 characters
                } else {
                    newData = data
                }
                OnTheMapClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
        // 7. Start the request and return it
        task.resume()
        return task
    }
    
    func taskForPOSTMethod(method: String, baseURL: String, headers: [String: String]?, jsonBody: [String: AnyObject]?, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // 1/2/3. Set parameters, build the url and configure the request
        let urlString = baseURL + method
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let jsonBody = jsonBody {
            do {
                request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonBody, options: .PrettyPrinted)
            }
        } else {
            print("passing through POST method in client")
        }
        
        print(request.allHTTPHeaderFields)
        print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)!)
        
        // 4. Make the request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            OnTheMapClient.manageErrors(data, response: response, error: error, completionHandler: completionHandler)
            
            // 5/6. Parse and use the data
            if let data = data {
                
                var newData: NSData
                // If data comes from Udacity, strip the first 5 characters
                if method == OnTheMapClient.Methods.UdacityPostSession {
                    newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                } else {
                    newData = data
                }
                
                OnTheMapClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
                
            }
        }
        
        // 7. start the request and return it
        task.resume()
        return task
        
    }
    
    func taskForDELETEMethod(method: String, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // 1/2/3. Set the parameters, build URL and configure request
        var baseURL = "https://"
        // If method is coming from Udacity, use UdacityBaseURL, otherwise use Parse
        if method == OnTheMapClient.Methods.UdacityDeleteSession {
            baseURL = Constants.UdacityBaseURL
        } else {
            baseURL = Constants.ParseBaseURL
        }
        
        let urlString = baseURL + method
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        // Cookie management
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        
        // 4. Manage the request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            OnTheMapClient.manageErrors(data, response: response, error: error, completionHandler: completionHandler)
            
            // 5/6. Parse the data and use it
            if let data = data {
                var newData: NSData
                // If data comes from Udacity, strip the first 5 characters
                if method == OnTheMapClient.Methods.UdacityDeleteSession {
                    newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                } else {
                    newData = data
                }
                OnTheMapClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
        
        // 7. Start the request and return it
        task.resume()
        return task
        
    }
    
    
    
    // MARK: Helper functions
    
    // Helper for catching and managing errors
    class func manageErrors(data: NSData?, response: NSURLResponse?, error: NSError?, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        // Guard - Was there an error?
        guard (error == nil) else {
            print("Error: There was an error with this request: \(error)")
            let updatedError = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: error!.localizedDescription])
            completionHandler(result: nil, error: updatedError)
            return
            
        }
        
        // Guard - Did we get a successful 2XX response?
        guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
            if let response = response as? NSHTTPURLResponse {
                if response.statusCode == 403 {
                    print("Authentication Error: Invalid Username/Password")
                    completionHandler(result: nil, error: NSError(domain: "Authentication Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Username or Password!"]))
                } else {
                    print("Server Error: Request returned an invalid response. Status code: \(response.statusCode)")
                    completionHandler(result: nil, error: NSError(domain: "Server Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Username and Password cannot be blank!"]))
                }
            } else if let response = response {
                print("Server Error: Request returned an invalid response. Response: \(response)!")
                completionHandler(result: nil, error: NSError(domain: "Server Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request returned an invalid response. Response: \(response)!"]))
            } else {
                print("Server Error: Request returned an invalid response")
                completionHandler(result: nil, error: NSError(domain: "Server Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request returned an invalid response!"]))
            }
            return
        }
        
        // Guard - Was there any data returned?
        guard let _ = data else {
            print("Network Error: It appears that no data was returned by the request")
            completionHandler(result: nil, error: NSError(domain: "Network Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned by the request"]))
            return
        }
    }
    
    // Helper function to substitute key for value contained in method name
    class func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    // Helper function to take raw JSON and return usable Foundation object
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse data was JSON: '\(data)'"]
            completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandler(result: parsedResult, error: nil)
        
    }
    
    // Helper function to convert dictionary of parameters to string for use in a URL
    class func escapedParameters(parameters: [String: AnyObject]) -> String {
        
        var urlVars = [String]()
        for(key, value) in parameters {
            // Convert value to string if it's not already
            let stringValue = "\(value)"
            // Use built-in String methods to escape
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            // Append escaped value to the urlVars array
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        // return the data, if array is empty, return empty string, otherwise append "&" between elements
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
        
    }
    
    // Shared Instance
    
    class func sharedInstance() -> OnTheMapClient {
        
        struct Singleton {
            static var sharedInstance = OnTheMapClient()
        }
        
        return Singleton.sharedInstance
    }
    
}