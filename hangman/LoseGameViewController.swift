//
//  LoseGameViewController.swift
//  hangman
//
//  Created by Mark Miranda on 10/2/16.
//  Copyright © 2016 Mark Miranda. All rights reserved.
//

import UIKit

class LoseGameViewController: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var result: String!
    var toPass: String!
    var finalScore: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stringScore = String(finalScore)
        resultLabel.text = result
        wordLabel.text = "The secret word is \(toPass!.uppercased())"
        scoreLabel.text = "YOU SCORED \(stringScore) POINTS!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
