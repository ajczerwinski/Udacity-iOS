//
//  Meme.swift
//  MemeMe 1.0
//
//  Created by Allen Czerwinski on 3/9/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    
    private var _topText: String
    private var _bottomText: String
    private var _image: UIImage
    private var _memedImage: UIImage
    
    var topText: String {
        
        return _topText
        
    }
    
    var bottomText: String {
        
        return _bottomText
        
    }
    
    var image: UIImage {
        
        return _image
        
    }
    
    var memedImage: UIImage {
        
        return _memedImage
        
    }
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        
        self._topText = topText
        self._bottomText = bottomText
        self._image = image
        self._memedImage = memedImage
        
    }
    
    
}
