//
//  Game.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/26/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import Foundation

class Game {
    var settings = Settings()
    var team1 = Team()
    var team2 = Team()
    var numberOfPlayers = 0
    var words = [String]()
    var rounds = [Round]()
    private var currentRoundIndex = 0
    
    func setRounds() {
        let describeRound = Round(type: .describe, words: words, team1: team1, team2: team2)
        let actRound = Round(type: .act, words: words, team1: team1, team2: team2)
        let oneWordRound = Round(type: .oneword, words: words, team1: team1, team2: team2)
        rounds = [describeRound, actRound, oneWordRound]
    }
    
    func getCurrentRound() -> Round? {
        let currentRound = rounds[currentRoundIndex]
        if currentRound.bowl.unseenWords.count == 0 {
            self.currentRoundIndex += 1
            if (currentRoundIndex > rounds.count - 1) {
                return nil
            }
            let newRound = rounds[currentRoundIndex]
            newRound.currentTeamIndex = currentRound.currentTeamIndex
            return newRound
        }
        
        return currentRound
    }
}

class Settings {
    var turnTime = 60
    var wordsPerPlayer = 5
}

class Team {
    var name = String()
    var score = 0
}

enum RoundType: String {
    case describe = "Describe"
    case act = "Act"
    case oneword = "One Word"
}

class Round {
    var type = RoundType.describe
    let bowl: Bowl
    let team1: Team
    let team2: Team
    let teams: [Team]
    fileprivate var currentTeamIndex: Int
    var currentWord: String?
    
    init(type: RoundType, words: [String], team1: Team, team2: Team) {
        self.type = type
        self.bowl = Bowl(words: words)
        self.team1 = team1
        self.team2 = team2
        self.currentTeamIndex = 0
        self.teams = [team1, team2]
    }
    
    func startTurn() {
        currentWord = bowl.drawWord()
    }
    
    func endTurn() {
        self.switchTeam()
    }
    
    func wordSolved() {
        guard let current = currentWord else {
            print("Word should not be solved without a current word!")
            return
        }
        teams[currentTeamIndex].score += 1
        bowl.removeWord(word: current)
        currentWord = bowl.drawWord()
    }
    
    func wordSkipped() {
        teams[currentTeamIndex].score -= 1
        currentWord = bowl.drawWord()
    }
    
    func getCurrentTeam() -> Team {
        return teams[currentTeamIndex]
    }
    
    func switchTeam() {
        currentTeamIndex = (currentTeamIndex + 1) % teams.count
    }
}

class Bowl {
    
    var unseenWords = [String]()
    var seenWords = [String]()
    
    init(words: [String]) {
        unseenWords = words
    }
    
    func drawWord() -> String? {
        if unseenWords.count > 0 {
            let index = Int(arc4random_uniform(UInt32(unseenWords.count)))
            return unseenWords[index]
        }
        else {
            return nil
        }
    }
    
    func removeWord(word: String) {
        if let index = unseenWords.index(of: word) {
            unseenWords.remove(at: index)
            seenWords.append(word)
        }
    }
    
}
