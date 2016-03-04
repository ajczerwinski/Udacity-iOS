//
//  ViewController.swift
//  Click Counter
//
//  Created by Allen Czerwinski on 3/2/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    var label: UILabel!
    var secondLabel: UILabel!
    var decrementLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var label = UILabel()
        label.frame = CGRectMake(150, 150, 60, 60)
        label.text = "0"
        
        self.view.addSubview(label)
        self.label = label
        
        var secondLabel = UILabel()
        secondLabel.frame = CGRectMake(100, 100, 60, 60)
        secondLabel.text = "0"
        
        self.view.addSubview(secondLabel)
        self.secondLabel = secondLabel
        
        var decrementLabel = UILabel()
        decrementLabel.frame = CGRectMake(150, 200, 60, 60)
        decrementLabel.text = "0"
        
        self.view.addSubview(decrementLabel)
        self.decrementLabel = decrementLabel
        
        // Button
        
        var button = UIButton()
        button.frame = CGRectMake(150, 250, 60, 60)
        button.setTitle("Click", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        self.view.addSubview(button)
        
        button.addTarget(self, action: "incrementCount", forControlEvents:
            UIControlEvents.TouchUpInside)
        
        var decrementButton = UIButton()
        decrementButton.frame = CGRectMake(200, 300, 80, 80)
        decrementButton.setTitle("Decrement", forState: .Normal)
        decrementButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        self.view.addSubview(decrementButton)
        
        decrementButton.addTarget(self, action: "decrementCount", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    func incrementCount() {
        self.count++
        self.label.text = "\(self.count)"
        self.secondLabel.text = "\(self.count)"
        setBackgroundColor()
//        if self.view.backgroundColor.blueColor() == true {
//            
//        }
//        self.view
    }
    
    func decrementCount() {
        self.count--
        self.decrementLabel.text = "\(self.count)"
        setBackgroundColor()
    }

    func setBackgroundColor() {
        
        if self.count % 2 == 0 {
            self.view.backgroundColor = UIColor.redColor()
        } else {
            self.view.backgroundColor = UIColor.greenColor()
        }
    }

}

