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
            Constants.FlickrParameterKeys.GalleryID: "66911286-72157647263150569",
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
            
        ]
        
        for (key, value) in methodParameters {
            print("\(key): \(value)")
        }
        
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
            func displayError(error: String) {
                print(error)
                print("URL at time of error: \(url)")
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                }
            }
            
            // GUARD: Was there an error?
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            // GUARD: Did we get a successful 2XX response?
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode
                where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                    return
            }
            
            // GUARD: Was there any data returned?
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // parse the data
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            }
            catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            // GUARD: Did Flickr return an error (stat != ok)?
            guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String where stat == Constants.FlickrResponseValues.OKStatus else {
                displayError("Flickr API returned an error. See error code and message in \(parsedResult)")
                return
            }
            
            // GUARD: Are the "photos" and "photo" keys in our result?
            guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject], photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] else {
                displayError("Cannot find keys '\(Constants.FlickrResponseKeys.Photos)' and '\(Constants.FlickrResponseKeys.Photo)' in \(parsedResult)")
                return
            }
            
            // select a random photo
            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
            let photoDictionary = photoArray[randomPhotoIndex] as [String:AnyObject]
            let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
            
            // GUARD: Does our photo have a key for 'url_m'?
            guard let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
                displayError("Cannot find key '\(Constants.FlickrResponseKeys.MediumURL)' in \(photoDictionary)")
                return
            }
            
            // If an image exists at the url, set the image and title
            let imageURL = NSURL(string: imageUrlString)
            if let imageData = NSData(contentsOfURL: imageURL!) {
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                    self.photoImageView.image = UIImage(data: imageData)
                    self.photoTitleLabel.text = photoTitle ?? "(Untitled)"
                    }
                } else {
                    displayError("Image does not exist at \(imageURL)")
                }
            }
        task.resume()
    }
    
//            if error == nil {
                // there was data returned
//                if let data = data {
                
                    
//                    print(parsedResult)
                    
//                    if let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String: AnyObject],
//                        photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] {
//                            print(photoArray[0])
                            
//                            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
//                            let photoDictionary = photoArray[randomPhotoIndex] as [String:AnyObject]
//                            let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
                            
//                            if let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String {
//                                let imageURL = NSURL(string: imageUrlString)
//                                if let imageData = NSData(contentsOfURL: imageURL!) {
//                                    performUIUpdatesOnMain {
//                                        self.setUIEnabled(true)
//                                        self.photoImageView.image = UIImage(data: imageData)
//                                        self.photoTitleLabel.text = photoTitle ?? "(Untitled)"
//                                    }
//                                }
//                            }
            
//                        }
            
//                    }
                
//                }
            
//            }
    
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