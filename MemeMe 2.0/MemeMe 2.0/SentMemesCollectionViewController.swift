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
        
        let space: CGFloat = 3.0
        let width = view.frame.size.width
        let height = view.frame.size.height
        var dimension: CGFloat
        print(height)
        print(width)
        
//        let widthDimension = (self.view.frame.size.width - (2 * space)) / 3.0
//        
//        let heightDimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        let frameSize = collectionView?.frame.size
//        let shorterSide = min(frameSize!.height, frameSize!.width)
        if height > width {
            
            dimension = (width - (2 * space)) / 3.0
        } else {
            dimension = (height - (5 * space)) / 6.0
        }
        
        collectionView?.clipsToBounds = true
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
//        let frameSize = collectionView?.frame.size
//        
//        let shorterSide = min((frameSize?.width)!, frameSize!.height)
    
//        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        memes = applicationDelegate.memes
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        let space: CGFloat = 3.0
        let width = view.frame.size.width
        let height = view.frame.size.height
        var dimension: CGFloat
        
        print(height)
        print(width)
        
        if height > width {
            
            dimension = (height - (2 * space)) / 3.0
        } else {
            dimension = (width - (5 * space)) / 6.0
        }
        collectionView?.clipsToBounds = true
        
        flowLayout.minimumInteritemSpacing = space
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
