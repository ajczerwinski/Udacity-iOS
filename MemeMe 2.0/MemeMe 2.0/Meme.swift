//
//  Meme.swift
//  MemeMe 2.0
//
//  Created by Allen Czerwinski on 3/14/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
        
    }
    
}