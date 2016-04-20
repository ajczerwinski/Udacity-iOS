//
//  TableViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class StudentListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        getStudentLocations()
        tableView.reloadData()
        
    }
    
    // Set the number of rows to the count of the studentArray (100 max)
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return StudentArray.sharedInstance.myArray.count

    }
    // Generate the data for each table row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as! StudentLocationTableViewCell
        let studentLocation = StudentArray.sharedInstance.myArray[indexPath.row]
        cell.studentName.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.pinImage.image = UIImage(named: "map_icon")
        
        return cell
    }
    
    // Load the link provided by the user when the table row is selected by the user
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let target = StudentArray.sharedInstance.myArray[indexPath.row]
        let targetToLoad = target.mediaURL
        if targetToLoad.rangeOfString("http") != nil {
            UIApplication.sharedApplication().openURL(NSURL(string: "\(targetToLoad)")!)
            
        } else {
            showAlert("Invalid Link!")
        }
    }

    // CITATION: got help with understanding the need to use (and how to implement) asynchronous
    // threading when populating the map data since if page is loaded before the completion handler
    // completes and doesn't have the asynchronous ability to get the data afterward, then no data
    // gets loaded to the page
    // https://discussions.udacity.com/t/problem-passing-student-data-array-to-map-view/44934
    func getStudentLocations() {
        
        OnTheMapClient.sharedInstance().getStudentLocations() { (success, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { 
                    AlertConvenience.showAlert(self, error: error!)
                })
            } else if success {
                print("got student data!")
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not get student data"])
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
    
    @IBAction func reloadButtonPressed(sender: AnyObject) {
    
        // Refresh the student location data from Parse
        getStudentLocations()
        
    }
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        // Delete the user session so user is no longer logged in to the app
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
