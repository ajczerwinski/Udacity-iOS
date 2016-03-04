//
//  ViewController.swift
//  RoShamBo
//
//  Created by Allen Czerwinski on 3/3/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func gameButtonPressedRock() {
        
        var controller: ResultsViewController
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("ResultsViewController") as! ResultsViewController
        
        controller.playerRoShamBoChoice = "Rock"
        controller.opponentRoShamBoChoice = self.randomOpponentRoShamBo()
        
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func gameButtonPressedPaper() {
        
        performSegueWithIdentifier("playGamePaper", sender: self)
        
    }
    
    func randomOpponentRoShamBo() -> String {
        
        let randomValue = Int(arc4random_uniform(3)) + 1
        var opponentRoShamBo = ""
        
        // Convert the output to a Rock/Paper/Scissors result
        switch(randomValue) {
        case 1:
            opponentRoShamBo = "Rock"
        case 2:
            opponentRoShamBo = "Paper"
        case 3:
            opponentRoShamBo = "Scissors"
        default:
            print("problem with arc4random_uniform apparently")
        }
        print(opponentRoShamBo)
        return opponentRoShamBo
    }
    
    


}

