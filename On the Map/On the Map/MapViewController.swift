//
//  MapViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        populateStudentLocations()
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
    
    func setMapLocations() {
        
        var annotations = [MKPointAnnotation]()
        
        for location in StudentLocation.sharedInstance.studentArray {
            
            let latitude = CLLocationDegrees(location.latitude! as Double)
            let longitude = CLLocationDegrees(location.longitude! as Double)
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(location.firstName!) \(location.lastName!)"
            annotation.subtitle = location.mediaURL! as! String
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.grayColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
        
    }
    
}
