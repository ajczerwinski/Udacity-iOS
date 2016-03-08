//
//  ViewController.swift
//  Image Picker Practice
//
//  Created by Allen Czerwinski on 3/6/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var topTextField: UITextField!

    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        if imagePickerView.image == nil {
            topTextField.hidden = true
            bottomTextField.hidden = true
        } else {
            topTextField.hidden = false
            bottomTextField.hidden = false
        }
        
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.Center
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
            imagePickerView.layer.cornerRadius = 5.0
            imagePickerView.clipsToBounds = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    

}

