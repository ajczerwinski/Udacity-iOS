//
//  ViewController.swift
//  RoShamBo
//
//  Created by Allen Czerwinski on 3/3/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func gameButtonPressedRock() {
        
        var controller: ResultsViewController
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("ResultsViewController") as! ResultsViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func gameButtonPressedPaper() {
        
        performSegueWithIdentifier("playGamePaper", sender: self)
        
    }
    


}

