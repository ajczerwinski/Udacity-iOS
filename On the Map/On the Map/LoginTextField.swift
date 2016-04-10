//
//  LoginTextField.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/10/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

// CITATION: Got the idea to use a custom UITextField class to control the text position and
// text color from a Udemy class I took called 'iOS 9 and Swift 2, From Beginner to Paid
// Professional. Also got idea for setting placeholder text color to white from Stack Overflow
// question: http://stackoverflow.com/questions/26076054/changing-placeholder-text-color-with-swift

class LoginTextField: UITextField {
    
    // Inset the placeholder text 10 pixels
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    // Inset the text while editing by 10 pixels
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    // Set RGB parameters to create a light orange background color that looks good with the
    // Udacity login background
    
    let backgroundColorRed: CGFloat = 251.0 / 255.0
    let backgroundColorGreen: CGFloat = 188.0 / 255.0
    let backgroundColorBlue: CGFloat = 149.0 / 255.0
    
    // Set background color
    override func awakeFromNib() {
        layer.backgroundColor = UIColor(red: backgroundColorRed, green: backgroundColorGreen, blue: backgroundColorBlue, alpha: 1.0).CGColor
        textColor = UIColor.whiteColor()
        tintColor = UIColor.whiteColor()
    }
    
}
