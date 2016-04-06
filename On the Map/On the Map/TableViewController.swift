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
        getStudentLocations()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if studentLocation.count <= 100 {
//            return studentLocation.count
//        } else {
//            return 100
//        }
        
//        print(StudentLocationCollection.sharedInstance().collection.count)
        return StudentLocationCollection.sharedInstance().collection.count
//        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as! StudentLocationTableViewCell
        let studentLocation = StudentLocationCollection.sharedInstance().collection[indexPath.row]
        
//        let student = self.studentLocation[indexPath.row]
//        
//        cell.pinImage.image = UIImage(named: "map_icon")
//        cell.pinImage.contentMode = UIViewContentMode.ScaleAspectFit
//        cell.studentName.text = "\(student["firstName"]!) \(student["lastName"]!)"
        
//        return cell
//        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as! StudentLocationTableViewCell
//        let student = StudentLocationCollection.sharedInstance().collection[indexPath.row]
//        let student = studentLocation[indexPath.row]
//        cell.studentName.text = ("\(student) \(student)")
        cell.studentName.text = studentLocation.firstName
        cell.pinImage.image = UIImage(named: "map_icon")!
        
        
        return cell
    }
    
    func getStudentLocations() {
        
        ParseClient.sharedInstance().getUserStudentLocations() { (success, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { 
                    print("Error in getting student location data")
                })
            } else if success {
                print("got student data!")
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                print("could not get student data")
                })
            }
        
        }
    }
}
