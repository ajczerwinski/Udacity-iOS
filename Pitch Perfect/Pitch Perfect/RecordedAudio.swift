//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Allen Czerwinski on 3/1/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    // CITATION: I got help figuring out the initializer
    // portion of the code review from the Udacity forum
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}