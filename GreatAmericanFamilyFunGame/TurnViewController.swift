//
//  TurnViewController.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/27/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

class TurnViewController: UIViewController {
    
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    var round: Round!
    var seconds = 0
    //var timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
    var timer = Timer()
    
    @IBAction func skipTapped(_ sender: UIButton) {
        round.wordSkipped()
        self.nextWord()
    }

    @IBAction func correctTapped(_ sender: UIButton) {
        round.wordSolved()
        self.nextWord()
    }
    
    func updateTime() {
        seconds -= 1
        secondsLabel.text = String(seconds)
        if seconds == 0 {
            self.turnDone()
        }
    }
    
    func nextWord() {
        if round.currentWord == nil {
            self.turnDone()
        }
        wordLabel.text = round.currentWord
    }
    
    func turnDone() {
        round.endTurn()
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondsLabel.text = String(seconds)
        round.startTurn()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nextWord()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TurnViewController.updateTime), userInfo: nil, repeats: true)
    }
}
