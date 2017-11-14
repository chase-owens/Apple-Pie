//
//  Game.swift
//  Apple Pie
//
//  Created by Chase Owens on 11/11/17.
//  Copyright © 2017 Chase Owens. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedCharacters: [Character]
    
    
    mutating func playerGuessed(letter: Character) {
        guessedCharacters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
        
    }
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedCharacters.contains(letter) {
                guessedWord += "\(letter) "
            } else {
                guessedWord += "_ "
            }
        }
        return guessedWord.uppercased()
    }
    
}
