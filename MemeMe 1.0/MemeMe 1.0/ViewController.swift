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
    // CITATION: Found
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
//        NSBackgroundColorAttributeName: UIColor.clearColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: NSNumber(double: -3.0)
    ]

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
        
//        self.navigationController!.navigationBar.barTintColor = UIColor(red: navBackgroundColor, green: navBackgroundColor, blue: navBackgroundColor, alpha: 0.5)
//        
//        cameraButtonUI.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
//        
//        if imagePickerView.image == nil {
//            shareButtonUI.enabled = false
//        } else {
//            shareButtonUI.enabled = true
//        }
//        
//        topTextField.defaultTextAttributes = memeTextAttributes
//        bottomTextField.defaultTextAttributes = memeTextAttributes
//        
//        topTextField.textAlignment = .Center
//        bottomTextField.textAlignment = .Center
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func setTheScreenToDefault() {
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: navBackgroundColor, green: navBackgroundColor, blue: navBackgroundColor, alpha: 0.5)
        
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
        
        self.navigationController?.navigationBar.hidden = true
        toolbarUI.hidden = true
        
        // Render view to an image
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBar.hidden = false
        toolbarUI.hidden = false
        
        return memedImage
        
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
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(type: String?, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil

        setTheScreenToDefault()
        
//        self.navigationController!.navigationBar.barTintColor = UIColor(red: navBackgroundColor, green: navBackgroundColor, blue: navBackgroundColor, alpha: 0.5)
//        
//        cameraButtonUI.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
//        
//        if imagePickerView.image == nil {
//            shareButtonUI.enabled = false
//        } else {
//            shareButtonUI.enabled = true
//        }
//        
//        topTextField.defaultTextAttributes = memeTextAttributes
//        bottomTextField.defaultTextAttributes = memeTextAttributes
//        
//        topTextField.textAlignment = .Center
//        bottomTextField.textAlignment = .Center
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.Center
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
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
    
    func subscribeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }

    func unsubscribeFromKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }

    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
        
    }
    
}

