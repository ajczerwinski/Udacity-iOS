//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Allen Czerwinski on 3/9/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let navBackgroundColor: CGFloat = 235.0 / 255.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: navBackgroundColor, green: navBackgroundColor, blue: navBackgroundColor, alpha: 0.5)
    }


}

