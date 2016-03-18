//
//  MemeDetailViewController.swift
//  MemeMe 2.0
//
//  Created by Allen Czerwinski on 3/16/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var selectedMeme: Meme!
    
    
    @IBOutlet weak var memeDetailImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
     
        memeDetailImageView.image = selectedMeme.memedImage
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destinationViewController as! MemeEditorViewController
        navController.imagePickerView.image = selectedMeme.image
        navController.topTextField.text = selectedMeme.topText
        navController.bottomTextField.text = selectedMeme.topText
        
    }
    
    
    
}
