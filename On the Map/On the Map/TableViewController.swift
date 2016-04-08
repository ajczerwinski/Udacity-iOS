//
//  TableViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
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
}
