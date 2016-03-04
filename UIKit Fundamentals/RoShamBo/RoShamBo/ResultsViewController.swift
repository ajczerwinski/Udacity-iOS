//
//  ResultsViewController.swift
//  RoShamBo
//
//  Created by Allen Czerwinski on 3/3/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
   
    var playerRoShamBoChoice: String!
    var opponentRoShamBoChoice: String!
    
    @IBOutlet weak var gameResultImage: UIImageView!
    @IBOutlet weak var gameResultText: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        
        if opponentRoShamBoChoice == "Rock" {
            if playerRoShamBoChoice == "Rock" {
                self.gameResultImage.image = UIImage(named: "itsATie")
                self.gameResultText.text = "It's a tie!"
            } else if self.playerRoShamBoChoice == "Paper" {
                self.gameResultImage.image = UIImage(named: "PaperCoversRock")
                self.gameResultText.text = "Paper covers Rock, you win!"
            } else {
                self.gameResultImage.image = UIImage(named: "RockCrushesScissors")
                self.gameResultText.text = "Rock crushes Scissors, you lose!"
            }
        }
        switch(playerRoShamBoChoice) {
        case "Rock":
            if opponentRoShamBoChoice == "Rock" {
                self.gameResultImage.image = UIImage(named: "itsATie")
                self.gameResultText.text = "It's a tie!"
            } else if opponentRoShamBoChoice == "Paper" {
                self.gameResultImage.image = UIImage(named: "PaperCoversRock")
                self.gameResultText.text = "Paper covers Rock, you lose!"
            } else {
                self.gameResultImage.image = UIImage(named: "RockCrushesScissors")
                self.gameResultText.text = "Rock crushes Scissors, you win!"
            }
        case "Paper":
            if opponentRoShamBoChoice == "Rock" {
                self.gameResultImage.image = UIImage(named: "PaperCoversRock")
                self.gameResultText.text = "Paper covers Rock, you win!"
            } else if opponentRoShamBoChoice == "Paper" {
                self.gameResultImage.image = UIImage(named: "itsATie")
                self.gameResultText.text = "It's a tie!"
            } else {
                self.gameResultImage.image = UIImage(named: "ScissorsCutPaper")
                self.gameResultText.text = "Scissors cut Paper, you lose!"
            }
        case "Scissors":
            if opponentRoShamBoChoice == "Rock" {
                self.gameResultImage.image = UIImage(named: "RockCrushesScissors")
                self.gameResultText.text = "Rock crushes Scissors, you lose!"
            } else if opponentRoShamBoChoice == "Paper" {
                self.gameResultImage.image = UIImage(named: "ScissorsCutPaper")
                self.gameResultText.text = "Scissors cut Paper, you win!"
            } else {
                self.gameResultImage.image = UIImage(named: "itsATie")
                self.gameResultText.text = "It's a tie!"
            }
        default:
            print("Looks like nobody wins because yours truly messed something up")
            }
        } 
    
    
    
    
    
    @IBAction func playAgain() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}