//
//  RoundViewController.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/27/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController {
    
    @IBOutlet var roundTypeLabel: UILabel!
    @IBOutlet var roundDescriptionLabel: UILabel!
    @IBOutlet var teamLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var team1Label: UILabel!
    @IBOutlet var team2Label: UILabel!
    @IBOutlet var score1Label: UILabel!
    @IBOutlet var score2Label: UILabel!
    
    var game: Game!
    var round: Round!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setRoundInfo()
    }
    
    
    func setRoundInfo() {
        guard let currentRound = game.getCurrentRound() else {
            performSegue(withIdentifier: "GameOver", sender: self)
            return
        }
        
        round = currentRound
        roundTypeLabel.text = round.type.rawValue
        teamLabel.text = round.getCurrentTeam().name
        team1Label.text = round.team1.name
        team2Label.text = round.team2.name
        score1Label.text = String(round.team1.score)
        score2Label.text = String(round.team2.score)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartTurn" {
            let turnVC = segue.destination as! TurnViewController
            turnVC.round = round
            turnVC.seconds = game.settings.turnTime
        }
        else if segue.identifier == "GameOver" {
            let gameSummaryVC = segue.destination as! GameSummaryViewController
            gameSummaryVC.game = game
        }
    }
}
