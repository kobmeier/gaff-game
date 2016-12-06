//
//  WordInputCell.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/27/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

protocol WordInputDelegate: class {
    func onWordEditingChanged(cell: WordInputCell, word: String)
}

class WordInputCell: UITableViewCell {
    
    weak var wordInputDelegate: WordInputDelegate?
    @IBOutlet var wordInputField: UITextField!
    
    @IBAction func wordEditingChanged(_ sender: UITextField) {
        wordInputDelegate?.onWordEditingChanged(cell: self, word: sender.text ?? "")
    }
}
