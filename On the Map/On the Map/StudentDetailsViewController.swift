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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findOnMapButtonUI.layer.cornerRadius = 6
        submitButtonUI.layer.cornerRadius = 6
        
        enterURL.delegate = self
        enterLocation.delegate = self
        
        presentFirstUI()
        
    }
    
    
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
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}