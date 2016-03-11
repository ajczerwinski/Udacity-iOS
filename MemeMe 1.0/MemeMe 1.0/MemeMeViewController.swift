//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Allen Czerwinski on 3/9/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButtonUI: UIBarButtonItem!
    
    @IBOutlet weak var shareButtonUI: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolbarUI: UIToolbar!
    
    // Create Meme object to allow creating/saving/changing 
    // meme images
    
    struct Meme {
        
        var topText: String
        var bottomText: String
        var image: UIImage
        var memedImage: UIImage
        
    }
    
    // Specify the text attributes to approximate the Impact font
    // CITATION: Found solution to issue I was having where the text color was transparent in Udacity Forums: https://discussions.udacity.com/t/mememe-
    // transparent-text-in-textfield-no-white-background/21336/2
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: NSNumber(double: -3.0)
    ]
    
    // Background Color CGFloat constant for setting navigation bar background

    let navBackgroundColor: CGFloat = 235.0 / 255.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        setTheScreenToDefault()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    // Helper function to set screen to default
    
    func setTheScreenToDefault() {
        
        navigationController!.navigationBar.barTintColor = UIColor(red: navBackgroundColor, green: navBackgroundColor, blue: navBackgroundColor, alpha: 0.5)
        
        cameraButtonUI.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        if imagePickerView.image == nil {
            shareButtonUI.enabled = false
        } else {
            shareButtonUI.enabled = true
        }
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
    }
    
    func saveImage() {
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
        
        imagePickerView.image = meme.memedImage
        
    }
    
    func generateMemedImage() -> UIImage {
        
        navigationController?.navigationBar.hidden = true
        
        // Hide toolbar so it doesn't show in the memed image
        
        toolbarUI.hidden = true
        
        // Render view to an image
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.hidden = false
        
        // Un-hide toolbar now that memed image is captured
        
        toolbarUI.hidden = false
        
        return memedImage
        
    }
    
    @IBAction func pickAnImageButtonPressed(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        // Album button (sender.tag == 0) present photo library
        // Otherwise present camera
        
        if sender.tag == 0 {
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else {
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        }
        
        presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    // CITATION: Got significant help from Udacity Discussion forum post: 
    // https://discussions.udacity.com/t/spoiler-mememe-completionwithitemshandler
    // -and-saving-the-meme-struct/13203
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            activity, completed, returned, error in
            if completed {
            
                self.saveImage()
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
        }
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil

        setTheScreenToDefault()
        
    }
    
    // Specify details for how the image gets displayed in imagePickerView
    // Set content mode to aspect fit
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.Center
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
            imagePickerView.clipsToBounds = true
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // TextField Delegate methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.text = ""
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    // Turn on observers to listen for keyboard show and hide functions
    
    func subscribeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }

    // Turn off observers
    
    func unsubscribeFromKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    // If the bottom text field is selected, push the view up by the height
    // of the keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    
    }
    
    // Return view to its original position
    
    func keyboardWillHide(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }

    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
        
    }
    
}

