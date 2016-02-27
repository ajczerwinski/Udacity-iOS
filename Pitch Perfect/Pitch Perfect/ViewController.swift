//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Allen Czerwinski on 2/26/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        recordingInProgress.hidden = false
        stopButton.hidden = false
        print("in recordAudio")
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        recordingInProgress.hidden = true
    }
    

}

