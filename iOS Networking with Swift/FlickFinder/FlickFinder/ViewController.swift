//
//  ViewController.swift
//  FlickFinder
//
//  Created by Jarrod Parkes on 11/5/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {
    
    // MARK: Properties
    
    var keyboardOnScreen = false
    
    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var phraseTextField: UITextField!
    @IBOutlet weak var phraseSearchButton: UIButton!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latLonSearchButton: UIButton!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseTextField.delegate = self
        latitudeTextField.delegate = self
        longitudeTextField.delegate = self
        subscribeToNotification(UIKeyboardWillShowNotification, selector: Constants.Selectors.KeyboardWillShow)
        subscribeToNotification(UIKeyboardWillHideNotification, selector: Constants.Selectors.KeyboardWillHide)
        subscribeToNotification(UIKeyboardDidShowNotification, selector: Constants.Selectors.KeyboardDidShow)
        subscribeToNotification(UIKeyboardDidHideNotification, selector: Constants.Selectors.KeyboardDidHide)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    // MARK: Search Actions
    
    @IBAction func searchByPhrase(sender: AnyObject) {

        userDidTapView(self)
        setUIEnabled(false)
        
        if !phraseTextField.text!.isEmpty {
            photoTitleLabel.text = "Searching..."
            // TODO: Set necessary parameters!
            
            let methodParameters: [String: String!] = [
            
                Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.UseSafeSearch,
                Constants.FlickrParameterKeys.Text: phraseTextField.text,
                Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
                Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
                Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.SearchMethod,
                Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
                Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
            
            ]
            displayImageFromFlickrBySearch(methodParameters)
            
        } else {
            setUIEnabled(true)
            photoTitleLabel.text = "Phrase Empty."
        }
    }
    
    @IBAction func searchByLatLon(sender: AnyObject) {

        userDidTapView(self)
        setUIEnabled(false)
        
        if isTextFieldValid(latitudeTextField, forRange: Constants.Flickr.SearchLatRange) && isTextFieldValid(longitudeTextField, forRange: Constants.Flickr.SearchLonRange) {
            photoTitleLabel.text = "Searching..."
            // TODO: Set necessary parameters!
            
            let methodParameters: [String: String!] = [
                
                Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.UseSafeSearch,
                Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
                Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
                Constants.FlickrParameterKeys.BoundingBox: bboxString(),
                Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.SearchMethod,
                Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
                Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
                
            ]
            
            displayImageFromFlickrBySearch(methodParameters)
        }
        else {
            setUIEnabled(true)
            photoTitleLabel.text = "Lat should be [-90, 90].\nLon should be [-180, 180]."
        }
    }
    
    private func bboxString() -> String {
        
        if let longitude = Double(longitudeTextField.text!), let latitude = Double(latitudeTextField.text!) {
            
            let minimumLon = max(longitude - Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.0)
            let minimumLat = max(latitude - Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.0)
            let maximumLon = min(longitude + Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.1)
            let maximumLat = min(latitude + Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.1)
            return "\(minimumLon),\(minimumLat),\(maximumLon),\(maximumLat)"
            
        } else {
            return "0, 0, 0, 0"
        }
        
    }
    
    // MARK: Flickr API
    
    private func displayImageFromFlickrBySearch(methodParameters: [String:AnyObject]) {
        
//        print(flickrURLFromParameters(methodParameters, withPageNumber: randomPage))
    
        // TODO: Make request to Flickr!
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: flickrURLFromParameters(methodParameters))
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
        
            func displayError(error: String) {
                print(error)
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                    self.photoTitleLabel.text = "No photo returned. Try again."
                    self.photoImageView.image = nil
                }
            }
//            if error == nil {
//                print(data)
//            } else {
//                print(error!.localizedDescription)
//            }
            
            // Check for error
            guard (error == nil) else {
                displayError("There was an error with the request: \(error)")
                return
            }
            
            // Check if the code response is successful (2xx)
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            // Check to see if data was returned
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
            
            guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String where stat == Constants.FlickrResponseValues.OKStatus else {
                displayError("Flickr API returned an error. See error code and message in \(parsedResult)")
                return
            }
            
            guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject] else {
                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Photos)' in \(parsedResult)")
                return
            }

                
            guard let totalPages = photosDictionary[Constants.FlickrResponseKeys.Pages] as? Int else {
                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Pages)' in \(photosDictionary)")
                return
            }
                
            let pageLimit = min(totalPages, 40)
            let randomPage = Int(arc4random_uniform(UInt32(pageLimit))) + 1
            self.displayImageFromFlickrBySearch(methodParameters, withPageNumber: randomPage)
            
        }
//            guard let photosArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String: AnyObject]] else {
//                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Photo)' in \(photosDictionary)")
//                return
//            }
//            
//            if photosArray.count == 0 {
//                displayError("No Photos Found. Search Again.")
//                return
//            } else {
//                let randomPhotoIndex = Int(arc4random_uniform(UInt32(photosArray.count)))
//                let photoDictionary = photosArray[randomPhotoIndex] as [String:AnyObject]
//                let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
//                
//                // Does our photo have a key for 'url_m'?
//                guard let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
//                    displayError("Cannot find key '\(Constants.FlickrResponseKeys.MediumURL)' in \(photoDictionary)")
//                    return
//                }
            
                
                
                
            
                
                // If an image exists at the url, set the image and title
                
//                let imageURL = NSURL(string: imageUrlString)
//                if let imageData = NSData(contentsOfURL: imageURL!) {
//                    performUIUpdatesOnMain {
//                        self.setUIEnabled(true)
//                        self.photoImageView.image = UIImage(data: imageData)
//                        self.photoTitleLabel.text = photoTitle ?? "(Untitled)"
//                    }
//                } else {
//                    displayError("Image does not exist at \(imageURL)")
//                }
            
            
            
//            // Did Flickr return an error? (stat != ok)?
//            guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String where stat == Constants.FlickrResponseValues.OKStatus else {
//                displayError("Flickr API returned an error. See error code and message in \(parsedResult)")
//                return
//            }
//            
//            // Are the "photos" and "photo" keys in our result?
//            guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject] else {
//                displayError("Cannot find keys '\(Constants.FlickrResponseKeys.Photos)' and '\(Constants.FlickrResponseKeys.Photos)' in \(parsedResult)")
//                return
//            }
//            
//            guard let photosArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String: AnyObject]] else {
//                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Photo)' in \(photosDictionary)")
//                return
//            }
            
//            self.photoImageView.image = photosArray[0]["photo"]
//            self.photoTitleLabel.text =
            
//            guard let totalPages = photosDictionary[Constants.FlickrResponseKeys.Pages] as? Int else {
//                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Pages)' in \(photosDictionary)")
//                return
//            }
            
            // Pick a random page
            
//            let pageLimit = min(totalPages, 40)
//            let randomPage = Int(arc4random_uniform(UInt32(pageLimit))) + 1
//            self.displayImageFromFlickrBySearch(methodParameters)
//            
//            guard let imageUrlString = photosDictionary[Constants.FlickrResponseKeys.Pages] as? String else {
//                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Pages)' in \(photosDictionary)")
//                return
//            }
        
        
        task.resume()
    }
    
    private func displayImageFromFlickrBySearch(var methodParameters: [String:AnyObject], withPageNumber: Int) {
        
        // add the page to the method's parameters
        methodParameters[Constants.FlickrParameterKeys.Page] = withPageNumber
        
        // create session and request
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: flickrURLFromParameters(methodParameters))
        
        // create network request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
         
            // if an error occurs, print it and re-enable the UI
            func displayError(error: String) {
                print(error)
                performUIUpdatesOnMain {
                self.setUIEnabled(true)
                self.photoTitleLabel.text = "No photo returned. Try again."
                self.photoImageView.image = nil
                }
            }
            
            // Was there an error?
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            // Did we get a successful 2XX response?
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            // Was there any data returned?
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // Parse the data
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            // Did Flickr return an error (stat != ok)?
            guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String where stat == Constants.FlickrResponseValues.OKStatus else {
                displayError("Flickr API returned an error. See error code and message in \(parsedResult)")
                return
            }
            
            // Is the "photo" key in our result?
            guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String: AnyObject] else {
                displayError("Cannot find key \(Constants.FlickrResponseKeys.Photos)' in \(parsedResult)")
                return
            }
            
            // Is the "photo" key in photosDictionary?
            guard let photosArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String: AnyObject]] else {
                displayError("Cannot find key '\(Constants.FlickrResponseKeys.Photo)' in \(photosDictionary)")
                return
            }
            
            if photosArray.count == 0 {
                displayError("No Photos Found. Search Again.")
                return
            } else {
                let randomPhotoIndex = Int(arc4random_uniform(UInt32(photosArray.count)))
                let photoDictionary = photosArray[randomPhotoIndex] as [String: AnyObject]
                let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
                
                // Does our photo have a key for 'url_m'?
                guard let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
                    displayError("Cannot find key '\(Constants.FlickrResponseKeys.MediumURL)' in \(photoDictionary)")
                    return
                }
                
                // if an image exists at the url, set the image and title
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
            
        }
        
        // Start the task!
        task.resume()
        
    }
    
    // MARK: Helper for Creating a URL from Parameters
    
    private func flickrURLFromParameters(parameters: [String:AnyObject]) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
}

// MARK: - ViewController: UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardOnScreen {
            view.frame.origin.y -= keyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardOnScreen {
            view.frame.origin.y += keyboardHeight(notification)
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(notification: NSNotification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(phraseTextField)
        resignIfFirstResponder(latitudeTextField)
        resignIfFirstResponder(longitudeTextField)
    }
    
    // MARK: TextField Validation
    
    private func isTextFieldValid(textField: UITextField, forRange: (Double, Double)) -> Bool {
        if let value = Double(textField.text!) where !textField.text!.isEmpty {
            return isValueInRange(value, min: forRange.0, max: forRange.1)
        } else {
            return false
        }
    }
    
    private func isValueInRange(value: Double, min: Double, max: Double) -> Bool {
        return !(value < min || value > max)
    }
}

// MARK: - ViewController (Configure UI)

extension ViewController {
    
    private func setUIEnabled(enabled: Bool) {
        photoTitleLabel.enabled = enabled
        phraseTextField.enabled = enabled
        latitudeTextField.enabled = enabled
        longitudeTextField.enabled = enabled
        phraseSearchButton.enabled = enabled
        latLonSearchButton.enabled = enabled
        
        // adjust search button alphas
        if enabled {
            phraseSearchButton.alpha = 1.0
            latLonSearchButton.alpha = 1.0
        } else {
            phraseSearchButton.alpha = 0.5
            latLonSearchButton.alpha = 0.5
        }
    }
}

// MARK: - ViewController (Notifications)

extension ViewController {
    
    private func subscribeToNotification(notification: String, selector: Selector) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    private func unsubscribeFromAllNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}