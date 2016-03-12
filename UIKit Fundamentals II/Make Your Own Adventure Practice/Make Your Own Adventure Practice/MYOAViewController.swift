//
//  ViewController.swift
//  Make Your Own Adventure Practice
//
//  Created by Allen Czerwinski on 3/12/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class MYOAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over", style: .Plain, target: self, action: "startOver")
        
    }
    
    func startOver() {
        
        if let navigationController = self.navigationController {
            
            navigationController.popToRootViewControllerAnimated(true)
            
        }
        
    }
    
}

