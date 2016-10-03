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
    var toPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = "The secret word is \(toPass!.uppercased())"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwind(send: UI)
}
