//
//  StudentDetailsViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/8/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StudentDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topUIBar: UIView!
    @IBOutlet weak var bottomUIBar: UIView!
    
    @IBOutlet weak var whereUStudyingTop: UILabel!
    @IBOutlet weak var whereUStudyingMiddle: UILabel!
    @IBOutlet weak var whereUStudyingBottom: UILabel!
    
    @IBOutlet weak var enterURL: UITextField!
    @IBOutlet weak var enterLocation: UITextField!
    
    @IBOutlet weak var cancelButtonUI: UIButton!
    @IBOutlet weak var submitButtonUI: UIButton!
    @IBOutlet weak var findOnMapButtonUI: UIButton!
    
    @IBOutlet weak var activityViewIndicator: UIActivityIndicatorView!

    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentLocation = StudentArray.sharedInstance.studentLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findOnMapButtonUI.layer.cornerRadius = 6
        submitButtonUI.layer.cornerRadius = 6
        
        // Grab student's name for use when they submit their location/url later
        getStudentName()
        
        enterURL.delegate = self
        enterLocation.delegate = self
        
        activityViewIndicator.color = UIColor.grayColor()
        
        presentFirstUI()
        
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.text = ""
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        if let url = enterURL.text {
            // If the url doesn't have proper web url prefix, prepend it
            if !url.hasPrefix("http://") && !url.hasPrefix("https://") {
                studentLocation.mediaURL = "http://" + url
            } else {
                studentLocation.mediaURL = url
            }
            postUserInfoToParse()
        // If blank, prompt the user to fill in URL field
        } else {
            showAlert("URL field cannot be blank")
        }
    }
    
    @IBAction func findOnTheMapButtonPressed(sender: AnyObject) {
       
        let address = enterLocation.text
        if let address = address {
            self.geocodeAddress(address)
        } else {
            print("Didn't get a location")
        }
        
        presentSecondUI()
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // UI Helper functions
    // Make the UI elements for the first view visible and hide second
    func presentFirstUI() {
        
        let cancelButtonColorRed: CGFloat = 57.0 / 255.0
        let cancelButtonColorGreen: CGFloat = 96.0 / 255.0
        let cancelButtonColorBlue: CGFloat = 139.0 / 255.0
        cancelButtonUI.tintColor = UIColor(red: cancelButtonColorRed, green: cancelButtonColorGreen, blue: cancelButtonColorBlue, alpha: 1.0)
        
        enterURL.hidden = true
        mapView.hidden = true
        submitButtonUI.hidden = true
        
        enterLocation.hidden = false
        
        whereUStudyingTop.hidden = false
        whereUStudyingMiddle.hidden = false
        whereUStudyingBottom.hidden = false
        
        topUIBar.hidden = false
        bottomUIBar.hidden = false
        
        findOnMapButtonUI.hidden = false
        
        activityViewIndicator.hidden = true
        
        
    }
    
    // Make the UI elements for the second view visible and hide first
    func presentSecondUI() {
        
        cancelButtonUI.tintColor = UIColor.whiteColor()
        
        enterURL.hidden = false
        mapView.hidden = false
        submitButtonUI.hidden = false
        
        enterLocation.hidden = true
        
        whereUStudyingTop.hidden = true
        whereUStudyingMiddle.hidden = true
        whereUStudyingBottom.hidden = true
        
        topUIBar.hidden = true
        bottomUIBar.hidden = true
        
        findOnMapButtonUI.hidden = true
        
    }
    
    
    // Helper function to get geocoded address from user inputted search string
    
    func geocodeAddress(address: String) {
        
        let geocoder = CLGeocoder()
        activityViewIndicator.hidden = false
        activityViewIndicator.startAnimating()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            // If we find a match to the user-inputted address, pick the first one and get mapData from it
            
            if let placemark = placemarks?[0] {
                self.studentLocation.latitude = Double(placemark.location!.coordinate.latitude)
                self.studentLocation.longitude = Double(placemark.location!.coordinate.longitude)
                self.studentLocation.mapString = address
                // place pin on mapView
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                // set the map zoom distance
                self.mapView.setCenterCoordinate(placemark.location!.coordinate, animated: true)
                self.mapView.camera.altitude = 20000.0
                self.activityViewIndicator.stopAnimating()
                self.activityViewIndicator.hidden = true
                
            
            } else if let error = error {
                dispatch_async(dispatch_get_main_queue(), {
                    self.activityViewIndicator.stopAnimating()
                    self.activityViewIndicator.hidden = true
                    AlertConvenience.showAlert(self, error: error)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.activityViewIndicator.stopAnimating()
                    self.activityViewIndicator.hidden = true
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to complete geocoding request"])
                })
            }
            
        })
        
    }
    
    // Helper function to get Student's name
    func getStudentName() {
        
        let results = OnTheMapClient.sharedInstance().getStudentName { (success, error, firstName, lastName, mediaURL) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    AlertConvenience.showAlert(self, error: error!)
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else if success {
                print("Got student's name, no further action")
                if let firstName = firstName, lastName = lastName, mediaURL = mediaURL {
                    self.studentLocation.firstName = firstName
                    self.studentLocation.lastName = lastName
                    self.studentLocation.mediaURL = mediaURL
                }
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Couldn't get student's name from server"])
                    AlertConvenience.showAlert(self, error: error)
                })
            }
        }
    }
    
    // Helper function to push User's name, location, and url to Parse server
    func postUserInfoToParse() {
        
        OnTheMapClient.sharedInstance().postStudentLocation(studentLocation) { (success, error) in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    AlertConvenience.showAlert(self, error: error!)
                })
            } else if success {
                print("successfully posted student location!")
                dispatch_async(dispatch_get_main_queue()) {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to post StudentLocation to Parse"])
                    AlertConvenience.showAlert(self, error: error)
                })
            }
        }
    }
    
    // Local alert helper function
    func showAlert(error: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: "", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
}