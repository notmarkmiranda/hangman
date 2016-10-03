//
//  GameViewController.swift
//  hangman
//
//  Created by Mark Miranda on 10/2/16.
//  Copyright © 2016 Mark Miranda. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var activeWord: UILabel!
    @IBOutlet weak var guessCount: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var wordArray = ["coffee", "sleep"]
    var guessesRemaining = 5
    var guessArray = [String]()
    var secretWord: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessCount.text = String(guessesRemaining)
        wordPicker()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitGuess() {
        if let userSubmitted = userInput.text {
            lengthChecker(character: userSubmitted)
        }
        
    }
    
    func lengthChecker(character: String) {
        if character.characters.count > 1 {
            clearAndDismiss()
            resultLabel.text = "YOU ENTERED TOO MANY CHARACTERS!"
        } else if regex(input: character) == false {
            clearAndDismiss()
            resultLabel.text = "THAT WASN'T A LETTER! TRY AGAIN."
            // check if the letter is right or wrong
        } else {
            print("happy path")
        }
    }
    
    func clearAndDismiss() {
        userInput.text = ""
        userInput.resignFirstResponder()
    }
    
    func wordPicker() {
        let randomIndex = Int(arc4random_uniform(UInt32(wordArray.count)))
        secretWord = wordArray[randomIndex]
        setWordLabel()
    }
    
    func setWordLabel() {
        for _ in secretWord.characters {
            guessArray.append("_")
        }
        
        activeWord.text = String(guessArray.joined(separator: " "))
    }
    
    func regex(input: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Za-z]").evaluate(with: input)
    }
    
}

