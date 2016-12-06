//
//  TurnViewController.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/27/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit
import AVFoundation

class TurnViewController: UIViewController {
    
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    var round: Round!
    var seconds = 0
    var timer = Timer()
    var audioPlayer: AVAudioPlayer!
    
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
        timer.invalidate()
        self.playBuzzer()
        round.endTurn()
        dismiss(animated: true, completion: nil)
    }
    
    func playBuzzer() {
        
        if let audioPath = Bundle.main.path(forResource: "buzzer", ofType: "wav") {
            let audioUrl = URL(fileURLWithPath: audioPath)
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioUrl)
                audioPlayer.play()
            }
            catch {
                print("Failed to create audio player")
            }
        }
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
