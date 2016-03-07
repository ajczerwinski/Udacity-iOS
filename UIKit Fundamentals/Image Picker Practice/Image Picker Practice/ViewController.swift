//
//  ViewController.swift
//  Image Picker Practice
//
//  Created by Allen Czerwinski on 3/6/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        self.presentViewController(pickerController, animated: true, completion: nil)
        
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController!)
        {
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    

}

