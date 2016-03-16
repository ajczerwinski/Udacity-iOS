//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Allen Czerwinski on 3/14/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewControllerController: UITableViewController {
    
    var memes = [Meme]()
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell") as! MemeTableCell
        let meme = self.memes[indexPath.row]
        
        cell.memeImage.image = meme.memedImage
        
        return cell
        
    }
    
    
    
}