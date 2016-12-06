//
//  WordInputViewController.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/27/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

class WordInputViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WordInputDelegate {
    
    @IBOutlet var tableView: UITableView!
    var game: Game!
    var playerWordArray = [String]()
    var currentPlayer = 1
    
    @IBAction func nextPlayerTapped(_ sender: UIBarButtonItem) {
        self.playerInputDone()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.resetPlayerWordArray()
        navigationItem.title = "PLAYER \(currentPlayer)"
    }
    
    func playerInputDone() {
        if playerWordArray.contains("") {
            let ac = UIAlertController(title: "ERROR", message: "PLEASE MAKE SURE THE WORDS ARE FILLED.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
        }
        else {
            game.words.append(contentsOf: playerWordArray)
            self.resetPlayerWordArray()
            currentPlayer += 1
            navigationItem.title = "Player \(currentPlayer)"
        }
    }
    
    func resetPlayerWordArray() {
        playerWordArray.removeAll()
        for _ in 0..<game.settings.wordsPerPlayer {
            playerWordArray.append("")
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.settings.wordsPerPlayer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordInputCell", for: indexPath) as! WordInputCell
        
        cell.wordInputDelegate = self
        cell.wordInputField.text = playerWordArray[indexPath.row]

        return cell
    }
    
    // MARK: - Word Input Delegate
    func onWordEditingChanged(cell: WordInputCell, word: String) {
        if let indexPath = tableView.indexPath(for: cell) {
            playerWordArray[indexPath.row] = word
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            self.playerInputDone()
            game.setRounds()
            let roundVC = segue.destination as! RoundViewController
            roundVC.game = game
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
