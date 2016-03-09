//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Allen Czerwinski on 3/9/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButtonUI: UIBarButtonItem!
    
    @IBOutlet weak var shareButtonUI: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolbarUI: UIToolbar!
    
    // Specify the text attributes to approximate the Impact font
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: NSNumber(double: 3.0)
    ]

    let navBackgroundColor: CGFloat = 235.0 / 255.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: navBackgroundColor, green: navBackgroundColor, blue: navBackgroundColor, alpha: 0.5)
        
        if imagePickerView.image == nil {
            shareButtonUI.enabled = false
        } else {
            shareButtonUI.enabled = true
        }
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        
    }


}

