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
    var incorrectArray = [String]()
    var secretWord: String!
    var underscores: Int!
    
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
            letterChecker(character: userSubmitted)
        }
        
    }
    
    func letterChecker(character: String) {
        if character.characters.count > 1 {
            clearAndDismiss()
            resultLabel.text = "YOU ENTERED TOO MANY CHARACTERS!"
        } else if regex(input: character) == false {
            clearAndDismiss()
            resultLabel.text = "THAT WASN'T A LETTER! TRY AGAIN."
        } else {
            clearAndDismiss()
            verifyLetter(input: character)
        }
    }
    
    func verifyLetter(input: String) {
        let tempUnderscores: Int = self.underscores
        for (index, letter) in secretWord.characters.enumerated() {
            let stringLetter = String(letter)
            if stringLetter == input.lowercased() {
                guessArray[index] = stringLetter.uppercased()
                underscores! -= 1
            }
            
        }
        loseATurn(oldUnderscores: tempUnderscores, letterInput: input)
        updateWordLabels()
    }
    
    func loseATurn(oldUnderscores: Int, letterInput: String) {
        if oldUnderscores == underscores {
            guessesRemaining -= 1
            incorrectArray.append(letterInput.uppercased())
        }
        checkTheCount()
    }
    
    func checkTheCount() {
        if guessesRemaining == 0 {
            self.performSegue(withIdentifier: "loseEndGame", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this is where you stopped
        if segue.identifier == "loseEndGame" {
            if let viewController = segue.destination as? LoseGameViewController {
            
                viewController.toPass = secretWord
                //viewController.property = property
            }
            
//            let indexPath = self.tableView.indexPathForSelectedRow {
//            let selectedVehicle = vehicles[indexPath.row]
//            nextScene.currentVehicle = selectedVehicle
        }
    }
    
    
    func updateWordLabels() {
        guessCount.text = String(guessesRemaining)
        activeWord.text = String(guessArray.joined(separator: " "))
        wrongLetters.text = String(incorrectArray.joined(separator: " "))
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
        underscores = 0
        for _ in secretWord.characters {
            underscores! += 1
            guessArray.append("_")
        }
        activeWord.text = String(guessArray.joined(separator: " "))
    }
    
    func regex(input: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Za-z]").evaluate(with: input)
    }
    
}

