//
//  MemeCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Allen Czerwinski on 3/14/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        manageCellDimensions()
        
    }
    
    // CITATION relied heavily on the following two sources:
    // https://discussions.udacity.com/t/mememe-collectionview-flow-layout/39382/2
    // http://stackoverflow.com/questions/28325277/how-to-set-cell-
    // spacing-and-uicollectionview-uicollectionviewflowlayout-size-r
    
    // Customize the layout of the Collection View
    
    func manageCellDimensions() {
        
        let space: CGFloat = 2.0
        let width = view.frame.size.width
        let height = view.frame.size.height
        var dimension: CGFloat
        
        if height > width {
            
            dimension = (width - (2 * space)) / 3.2
            flowLayout.minimumInteritemSpacing = space

        } else {
            dimension = (width - (5 * space)) / 6.0
            flowLayout.minimumInteritemSpacing = space * 5

        }
        collectionView?.clipsToBounds = true

        
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        manageCellDimensions()
        
        collectionView!.reloadData()
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme =  self.memes[indexPath.item]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
