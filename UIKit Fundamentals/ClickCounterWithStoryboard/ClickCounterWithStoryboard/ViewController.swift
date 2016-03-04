//
//  ViewController.swift
//  ClickCounterWithStoryboard
//
//  Created by Allen Czerwinski on 3/3/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func incrementCount() {
        self.count++
        self.label.text = "\(self.count)"
    }


}

