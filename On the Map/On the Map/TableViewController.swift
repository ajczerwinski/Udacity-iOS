//
//  TableViewController.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var studentLocation: [StudentLocation] = [StudentLocation]()
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studentLocation.count <= 100 {
            return studentLocation.count
        } else {
            return 100
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as! StudentLocationTableViewCell
        let student = self.studentLocation[indexPath.row]
        
        cell.pinImage.image = UIImage(named: "map_icon.png")
        cell.pinImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.studentName.text = "\(student.firstName) \(student.lastName)"
        
        return cell
    }
    
}
