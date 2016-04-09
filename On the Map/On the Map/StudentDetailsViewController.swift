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
    
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}