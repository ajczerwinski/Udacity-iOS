//
//  ViewController.swift
//  SleepingInTheLibrary
//
//  Created by Jarrod Parkes on 11/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var grabImageButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func grabNewImage(sender: AnyObject) {
        setUIEnabled(false)
        getImageFromFlickr()
    }
    
    // MARK: Configure UI
    
    private func setUIEnabled(enabled: Bool) {
        photoTitleLabel.enabled = enabled
        grabImageButton.enabled = enabled
        
        if enabled {
            grabImageButton.alpha = 1.0
        } else {
            grabImageButton.alpha = 0.5
        }
    }
    
    // MARK: Make Network Request
    
    private func getImageFromFlickr() {
        
        // TODO: Write the network code here!
        
//        let url = NSURL(string: "\(Constants.Flickr.APIBaseURL)?\(Constants.FlickrParameterKeys.Method)=\(Constants.FlickrParameterValues.GalleryPhotosMethod)&\(Constants.FlickrParameterKeys.APIKey)=\(Constants.FlickrParameterValues.APIKey)&\(Constants.FlickrParameterKeys.GalleryID)=\(Constants.FlickrParameterValues.GalleryID)&\(Constants.FlickrParameterKeys.Extras)=\(Constants.FlickrParameterValues.MediumURL)&\(Constants.FlickrParameterKeys.Format)=\(Constants.FlickrParameterValues.ResponseFormat)&\(Constants.FlickrParameterKeys.NoJSONCallback)=\(Constants.FlickrParameterValues.DisableJSONCallback)")!
        
//        print(url)

        
        
//        let someParameters = [
//            "course": "networking",
//            "nanodegree": "ios",
//            "quiz": "escaping paramters"
//        ]
//        
//        print(escapedParameters(someParameters))
    
        let methodParameters = [
        
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.GalleryPhotosMethod,
            Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.GalleryID: Constants.FlickrParameterValues.GalleryID,
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
            
        ]
        
        let urlString = Constants.Flickr.APIBaseURL + escapedParameters(methodParameters)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        // There is a similar method called NSMutableURLRequest(URL: url) that we can use if
        // we want to change the type of request.HTTPMethod. In this example we can use the regular
        // NSURLRequest because "GET" is the default type of HTTPMethod, but in the future we'll
        // use the mutable one when necessary
        
        // let request = NSMutableURLRequest(URL: url)
        //request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
//            // if error occurs, print it and re-enable the UI
//            func displayError(error: String) {
//                print(error)
//                print("URL at time of error: \(url)")
//                performUIUpdatesOnMain {
//                    self.setUIEnabled(true)
//                }
//            }
            
            if error == nil {
                // there was data returned
                if let data = data {
                    
                    let parsedResult: AnyObject!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    }
                    catch {
//                        displayError("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    print(parsedResult)
                    
                    if let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String: AnyObject],
                        photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] {
//                            print(photoArray[0])
                            
                            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                            let photoDictionary = photoArray[randomPhotoIndex] as [String:AnyObject]
                            let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
                            
                            if let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String {
                                let imageURL = NSURL(string: imageUrlString)
                                if let imageData = NSData(contentsOfURL: imageURL!) {
                                    performUIUpdatesOnMain {
                                        self.setUIEnabled(true)
                                        self.photoImageView.image = UIImage(data: imageData)
                                        self.photoTitleLabel.text = photoTitle ?? "(Untitled)"
                                    }
                                }
                            }
                            
                        }
                    
                    }
                
                }
                
            }
        task.resume()
    }
    
    private func escapedParameters(parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // Make sure that the value is a string
                let stringValue = "\(value)"
                
                // Escape it
                let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                
                // Append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joinWithSeparator("&"))"
        }
        
    }
}