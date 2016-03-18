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
    
//    var memes = [Meme]()
    
    var memes: [Meme]! {
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageCellDimensions()
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        manageCellDimensions()
        
    }
    
    func manageCellDimensions() {
        
        let space: CGFloat = 3.0
        let width = view.frame.size.width
        let height = view.frame.size.height
//        var dimension: CGFloat
        
        print(height)
        print(width)
        
//        if height > width {
//            
//            dimension = (width - (2 * space)) / 3.0
//            flowLayout.minimumInteritemSpacing = space
//        } else {
//            dimension = (width - (5 * space)) / 6.0
//            flowLayout.minimumInteritemSpacing = space * 3
//
//        }
//        collectionView?.clipsToBounds = true

        // CITATION testing this method for controlling cell layout from Udacity forum: 
        // https://discussions.udacity.com/t/mememe-collectionview-flow-layout/39382/2
        
        let dimension: CGFloat = view.frame.size.width >= view.frame.size.height ? (view.frame.size.width - (5 * space)) / 6.0 :  (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        collectionView!.reloadData()
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme =  self.memes[indexPath.item]
//        cell.setText(meme.topText, bottomString: meme.bottomText)
        
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
