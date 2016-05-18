//
//  MapViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import MapKit

class StudentMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        populateStudentLocations()
        
    }
    
    // CITATION: got help with understanding the need to use (and how to implement) asynchronous
    // threading when populating the map data since if page is loaded before the completion handler
    // completes and doesn't have the asynchronous ability to get the data afterward, then no data
    // gets loaded to the page
    // https://discussions.udacity.com/t/problem-passing-student-data-array-to-map-view/44934
    func populateStudentLocations() {
        OnTheMapClient.sharedInstance().getStudentLocations() { (success, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    AlertConvenience.showAlert(self, error: error!)
                })
            } else if success {
                print("Yay we got student data!")
                dispatch_async(dispatch_get_main_queue()) {
                    self.setMapLocations()
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not get student data for map"])
                    AlertConvenience.showAlert(self, error: error)
                })
            }
        }
    }
    
    // Create the Map annotations from user data
    func setMapLocations() {
        
        var annotations = [MKPointAnnotation]()
        
        for location in StudentArray.sharedInstance.myArray {
            
            let latitude = CLLocationDegrees(location.latitude as Double)
            let longitude = CLLocationDegrees(location.longitude as Double)
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(location.firstName) \(location.lastName)"
            annotation.subtitle = location.mediaURL as String
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
    }
    
    // Set basic attributes of the map annotations
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.blueColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    
    // Load in defaul browser the url address in the subtitle field of the annotaiton
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
        
    }
    
    @IBAction func reloadButtonPressed(sender: AnyObject) {
        
        // Remove all existing annotations so they aren't double counted
        for annotation: MKAnnotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
        
        // Get and set new locations and annotations
        populateStudentLocations()
        
    }
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        // Delete the user session and allow user to log out
        OnTheMapClient.sharedInstance().deleteSession { (success, error) in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    AlertConvenience.showAlert(self, error: error!)
                })
            } else if success {
                print("Session successfully deleted")
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not delete session/logout"])
                    AlertConvenience.showAlert(self, error: error)
                })
            }
        }
        
    }
    
    
}
