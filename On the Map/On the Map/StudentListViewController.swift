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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return StudentLocation.sharedInstance.studentArray.count

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as! StudentLocationTableViewCell
        let studentLocation = StudentLocation.sharedInstance.studentArray[indexPath.row]
        cell.studentName.text = "\(studentLocation.firstName!) \(studentLocation.lastName!)"
        cell.pinImage.image = UIImage(named: "map_icon")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let target = StudentLocation.sharedInstance.studentArray[indexPath.row]
        let targetToLoad = target.mediaURL!
        if targetToLoad.rangeOfString("http") != nil {
            UIApplication.sharedApplication().openURL(NSURL(string: "\(targetToLoad)")!)
            
        } else {
            showAlert("Invalid Link!")
        }
    }

    
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
    
    func showAlert(error: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: "", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    @IBAction func reloadButtonPressed(sender: AnyObject) {
    
        getStudentLocations()
        
    }
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
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
