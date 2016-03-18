//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Allen Czerwinski on 3/14/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewControllerController: UITableViewController {

    var memes: [Meme]! {
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        return appDelegate.memes
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    
    }
    
    // CITATION: Got significant help on delete function from Udacity forum thread:
    // https://discussions.udacity.com/t/delete-meme-tableview/17849
    
    // Swipe right to left to delete meme from table
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            
        }
        
        tableView.reloadData()
        
    }
    
    // Populate each cell with data from appropriate index of memes array
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell") as! MemeTableViewCell
        let meme = self.memes[indexPath.row]
        
        cell.memeImage.image = meme.memedImage
        cell.memeImage.backgroundColor = UIColor.grayColor()
        cell.memeText.text = "\(meme.topText) ... \(meme.bottomText)"
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Grabbing the DetailVC from Storyboard
        
        let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")
        
        let detailVC = object as! MemeDetailViewController
        
        // Populating the view controller with meme image from selected meme
        
        detailVC.selectedMeme = self.memes[indexPath.item]
        detailVC.hidesBottomBarWhenPushed = true
        
        // Presenting the view controller using navigation
        
        navigationController!.pushViewController(detailVC, animated: true)
        
    }
    
}