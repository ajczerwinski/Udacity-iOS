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
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentLocation = StudentLocation.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findOnMapButtonUI.layer.cornerRadius = 6
        submitButtonUI.layer.cornerRadius = 6
        
        enterURL.delegate = self
        enterLocation.delegate = self
        
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
                
            
            } else if let error = error {
                dispatch_async(dispatch_get_main_queue(), {
                    AlertConvenience.showAlert(self, error: error)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to complete geocoding request"])
                })
            }
            
        })
        
    }
    
}