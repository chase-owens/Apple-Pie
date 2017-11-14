//
//  ViewController.swift
//  Apple Pie
//
//  Created by Chase Owens on 11/9/17.
//  Copyright © 2017 Chase Owens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //variables and outlets
    @IBOutlet weak var treeImage: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    
    let incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0
    
    var cummulativePoints = 0
    var totalPoints = 0
    
    var currentGame: Game!
    
    //Now loading view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newRound()
    }
    
    //Excuse This
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Arrays
    var wordList = ["dog", "cat", "bird", "bake", "bike", "book", "super", "word", "sun", "pizza", "tennis", "science", "math", "square", "triangle", "barking", "money"]

    var appleTreePics =  [#imageLiteral(resourceName: "Tree 0"), #imageLiteral(resourceName: "Tree 1"), #imageLiteral(resourceName: "Tree 2"), #imageLiteral(resourceName: "Tree 3"), #imageLiteral(resourceName: "Tree 4"), #imageLiteral(resourceName: "Tree 5"), #imageLiteral(resourceName: "Tree 6"), #imageLiteral(resourceName: "Tree 7")]

    
    //functions and actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let lettterString = sender.currentTitle!
        let letter = Character(lettterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateScore()
        updateUI()
    }
    
    func updateScore() {
        let currentCharacter = currentGame.guessedCharacters.last!
        if currentGame.word.contains(currentCharacter) {
            totalPoints += 3
            cummulativePoints += 3
        }
    }
    
    func newRound() {
        let newWord = wordList.removeFirst()
        if wordList.isEmpty {
            wordList += ["dog", "cat", "bird", "bake", "bike", "book", "super", "word", "sun", "pizza", "tennis", "science", "math", "square", "triangle", "barking", "money"]
        }
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedCharacters: [])
        for buttons in letterButtons {
            if buttons.isEnabled == false {
                buttons.isEnabled = true
            }
        }
        updateUI()
    }
    
    func restartGame() {
        let wordUnableToGuess = currentGame.word
        wordList.insert(wordUnableToGuess, at: 0)
    }
    
    func updateGameState() {
        if !currentGame.formattedWord.contains("_") {
            totalWins += 1
            cummulativePoints += 3
            totalPoints += 3
            newRound()
        }
        
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            restartGame()
            newRound()
        }
    }
    
    func updateUI() {
        updateGameState()
        totalPointsLabel.text = "Total Points: \(totalPoints)"
        scoreLabel.text = "Wins: \(totalWins), Loses: \(totalLosses)"
        treeImage.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        correctWordLabel.text = currentGame.formattedWord
    }
    
}

