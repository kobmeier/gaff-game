//
//  ViewController.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/26/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var team1Name: UITextField!
    @IBOutlet var team2Name: UITextField!
    @IBOutlet var wordsPerPlayerField: UITextField!
    @IBOutlet var secondsPerTurnField: UITextField!
    var game: Game!
    private static let kSettingsDoneSegue = "SettingsDone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SettingsViewController.kSettingsDoneSegue {
            if let turnTimeInt = Int(secondsPerTurnField.text ?? ""), let wordNumberInt = Int(wordsPerPlayerField.text ?? "") {
                if team1Name.text?.characters.count == 0 {
                    game.team1.name = "TEAM 1"
                }
                else {
                    game.team1.name = team1Name.text!
                }
                
                if team2Name.text?.characters.count == 0 {
                    game.team2.name = "TEAM 2"
                }
                else {
                    game.team2.name = team2Name.text!
                }
                
                game.settings.turnTime = turnTimeInt
                game.settings.wordsPerPlayer = wordNumberInt
                let wordInputVC = segue.destination as! WordInputViewController
                wordInputVC.game = game
                
            }
            else {
                let ac = UIAlertController(title: "ERROR", message: "PLEASE MAKE SURE THE NUMBERS ARE VALID.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                ac.addAction(okAction)
                present(ac, animated: true, completion: nil)
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if textField == team1Name {
            team2Name.becomeFirstResponder()
        }
        else if textField == team2Name {
            wordsPerPlayerField.becomeFirstResponder()
        }
        else if textField == wordsPerPlayerField {
            secondsPerTurnField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let castString: NSString = (textField.text ?? "") as NSString
        textField.text = castString.replacingCharacters(in: range, with: string.uppercased())

        return false
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

