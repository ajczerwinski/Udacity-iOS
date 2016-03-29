//
//  StudentLocation.swift
//  On the Map
//
//  Created by Allen Czerwinski on 3/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

struct StudentLocation {
    
    var firstName: String
    var lastName: String
    var pinImage: UIImage
    
    init(firstName: String, lastName: String, pinImage: UIImage) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.pinImage = pinImage
        
    }
    
}
