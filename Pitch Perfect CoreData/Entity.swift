//
//  Entity.swift
//  Pitch Perfect CoreData
//
//  Created by Allen Czerwinski on 2/29/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import CoreData
import AVFoundation


class Entity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func setRecordedAudio(audioFile: AVAudioSession) {
        let recording = AVAudioRecorder(audioFile)
        self.entity = audioFile
    }

}
