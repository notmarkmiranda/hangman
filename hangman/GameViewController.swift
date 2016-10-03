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
    var guessesRemaining = 0
    var guessArray = [String]()
    var incorrectArray = [String]()
    var secretWord: String!
    var underscores: Int!
    var score: Int!
    var winLoseString: String!
    
    func startGame() {
        guessesRemaining = 5
        score = 0
        guessCount.text = String(guessesRemaining)
        wordPicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loseEndGame" {
            if let viewController = segue.destination as? LoseGameViewController {
                viewController.result = winLoseString
                viewController.toPass = secretWord
                viewController.finalScore = score
            }
        }
    }

    
    @IBAction func submitGuess() {
        if let userSubmitted = userInput.text {
            letterChecker(character: userSubmitted)
        }
        
    }
    
    @IBAction func unwindToGame(segue: UIStoryboardSegue){
        resetGame()
    }
    
    func resetGame() {
        guessArray = []
        incorrectArray = []
        updateWordLabels()
        startGame()
    }
    
    func letterChecker(character: String) {
        if character.characters.count > 1 {
            resultLabel.text = "YOU ENTERED TOO MANY CHARACTERS!"
        } else if regex(input: character) == false {
            resultLabel.text = "THAT WASN'T A LETTER! TRY AGAIN."
        } else if doubleCheck(input: character) {
            resultLabel.text = "YOU ALREADY TRIED THAT LETTER! TRY AGAIN."
        } else {
            verifyLetter(input: character)
        }
        clearAndDismiss()
    }
    
    func doubleCheck(input: String) -> Bool {
        let inputFormatted = input.uppercased()
        let alreadyGuessedIncorrect = incorrectArray.contains(inputFormatted)
        let alreadyGuessedCorrect = guessArray.contains(inputFormatted)
        return alreadyGuessedCorrect || alreadyGuessedIncorrect
    }
    
    func verifyLetter(input: String) {
        let tempUnderscores: Int = self.underscores
        for (index, letter) in secretWord.characters.enumerated() {
            let stringLetter = String(letter)
            if stringLetter == input.lowercased() {
                guessArray[index] = stringLetter.uppercased()
                underscores! -= 1
                resultLabel.text = "GOOD JOB! KEEP IT GOING!"
            }
            
        }
        playTurn(oldUnderscores: tempUnderscores, letterInput: input)
        updateWordLabels()
    }
    
    func playTurn(oldUnderscores: Int, letterInput: String) {
        if oldUnderscores == underscores {
            guessesRemaining -= 1
            incorrectArray.append(letterInput.uppercased())
            resultLabel.text = "NOPE! TRY AGAIN."
        }
        checkTheCount()
    }
    
    func checkTheCount() {
        if guessesRemaining <= 0 {
            winLoseString = "YOU LOSE!"
            endGame()
        } else if underscores == 0 {
            winLoseString = "YOU WIN!"
            endGame()
        }
    }
    
    func endGame() {
        calculateScore()
        self.performSegue(withIdentifier: "loseEndGame", sender: self)
    }
    
    func calculateScore() {
        let turnsLeft = guessesRemaining * 50
        let solvedLetters = (secretWord.characters.count - underscores) * 25
        let totalScore = turnsLeft + solvedLetters
        score! += totalScore
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

