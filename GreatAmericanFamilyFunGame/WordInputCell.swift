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

class WordInputCell: UITableViewCell, UITextFieldDelegate {
    
    weak var wordInputDelegate: WordInputDelegate?
    @IBOutlet var wordInputField: UITextField!
    
    override func awakeFromNib() {
        wordInputField.autocapitalizationType = .allCharacters
        wordInputField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let castString: NSString = (textField.text ?? "") as NSString
        textField.text = castString.replacingCharacters(in: range, with: string.uppercased())
        
        wordInputDelegate?.onWordEditingChanged(cell: self, word: textField.text ?? "")
        
        return false
    }
}
