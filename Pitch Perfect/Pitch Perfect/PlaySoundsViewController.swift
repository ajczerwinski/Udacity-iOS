//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Allen Czerwinski on 2/28/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var audioURL: NSURL?
    var receivedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioPlayer.prepareToPlay()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButton(sender: UIButton) {
        
        audioPlayer.stop()
        
        
        if sender.tag == 0 {
            audioPlayer.rate = 0.5
        } else {
            audioPlayer.rate = 2.0
        }
        
        audioPlayer.play()
//        playSound.pause()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        audioPlayer.stop()
        
    }

}
