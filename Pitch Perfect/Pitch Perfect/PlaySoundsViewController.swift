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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        do {
            
            try slowSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!))
            slowSound.enableRate = true
            slowSound.prepareToPlay()
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
