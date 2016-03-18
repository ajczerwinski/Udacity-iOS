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
    
    // Set the view's image to the memed image
    
    override func viewWillAppear(animated: Bool) {
     
        memeDetailImageView.image = selectedMeme.memedImage
        
    }
    
}
