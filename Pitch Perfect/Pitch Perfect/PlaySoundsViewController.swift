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

    var slowSound: AVAudioPlayer!
    var fastSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        do {
            
            try slowSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!))
            try fastSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!))
            
            slowSound.enableRate = true
            fastSound.enableRate = true
            
            slowSound.prepareToPlay()
            fastSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowPlayButtonPressed(sender: UIButton) {
        
        slowSound.stop()
        slowSound.rate = 0.5
        slowSound.play()
        
    }
    
    @IBAction func fastPlayButtonPressed(sender: UIButton) {
        
        fastSound.stop()
        fastSound.rate = 2.0
        fastSound.play()
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        slowSound.stop()
        fastSound.stop()
        
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
