//
//  ViewController.swift
//  Experiment
//
//  Created by Allen Czerwinski on 3/3/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func experiment(sender: UIButton) {

    let controller = UIAlertController()
        controller.title = "Test alert"
        controller.message = "This is a test yo"
        
        let okAction = UIAlertAction(title: "ok yo", style: UIAlertActionStyle.Default) { action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        controller.addAction(okAction)
        self.presentViewController(controller, animated: true, completion: nil)
//
//        let nextController = UIImagePickerController()
//        
//        self.presentViewController(nextController, animated: true, completion: nil)
        
    }
    
    
    
}

