//
//  ViewController.swift
//  Color Maker with Sliders
//
//  Created by Allen Czerwinski on 3/3/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.borderWidth = 4
        colorView.layer.borderColor = UIColor.whiteColor().CGColor
    
    }
    
    @IBAction func sliderAction(sender: UISlider) {
        
        if self.redSlider == nil {
            return
        }
        
        let r: CGFloat = CGFloat(self.redSlider.value)
        let g: CGFloat = CGFloat(self.greenSlider.value)
        let b: CGFloat = CGFloat(self.blueSlider.value)
        
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    


}

