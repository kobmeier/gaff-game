//
//  GameSummaryViewController.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/27/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

class GameSummaryViewController: UIViewController {
    
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var team1Label: UILabel!
    @IBOutlet var team2Label: UILabel!
    @IBOutlet var score1Label: UILabel!
    @IBOutlet var score2Label: UILabel!
    var game: Game!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let score1 = game.team1.score
        let score2 = game.team2.score
        if score1 > score2 {
            winnerLabel.text = "Team \(game.team1.name) wins!"
        }
        else if score2 > score1 {
            winnerLabel.text = "Team \(game.team2.name) wins!"
        }
        else {
            winnerLabel.text = "Tie!"
        }
        
        team1Label.text = game.team1.name
        team2Label.text = game.team2.name
        score1Label.text = String(score1)
        score2Label.text = String(score2)
    }
}
