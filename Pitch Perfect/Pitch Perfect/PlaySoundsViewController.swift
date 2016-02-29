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

    var playSound: AVAudioPlayer!
    var slowSound: AVAudioPlayer!
    var fastSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        do {
            
            try playSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!))
//            try slowSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!))
//            try fastSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!))
            
//            slowSound.enableRate = true
//            fastSound.enableRate = true
            playSound.enableRate = true
            
            playSound.prepareToPlay()
//            slowSound.prepareToPlay()
//            fastSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButton(sender: UIButton) {
        
        playSound.stop()
        
        if sender.tag == 0 {
            playSound.rate = 0.5
        } else {
            playSound.rate = 2.0
        }
        
        playSound.play()
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        playSound.stop()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
