//
//  WordsController.swift
//  GameNight
//
//  Created by Julia Rodriguez on 7/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class WordsController {
    
    // singleton
    static let shared = WordsController()
    
    // Source Of Truth
    var word: String = ""
    
    //CRUD
    
    // Create
    func createRandomWord() {
        
        // generate randomn number
        let randomNumber = Int.random(in: 0...WordHelper.wordBank.count-1)
        
        let chosenWord = WordHelper.wordBank[randomNumber]
        word = chosenWord
    }
    
    func createHangManTemplate() -> String {
        
        var hangmanWord = ""
        
        let chosenWord = self.word
        
        for _ in chosenWord {
            
            hangmanWord += "_"
        }
        return hangmanWord
    }
    
    // Update
    func updateHangManWord(letter: Character) -> String {
        
        let chosenWord = self.word
        var hangmanWordUpdated = self.createHangManTemplate()
        
        if chosenWord.contains(letter) {
            
            // Array of string positions
            var indexArray: [String.Index] = []
            // Starting index
            var index: Int = 0
            // Loop through string
            for char in chosenWord {
                
                // init a string.index from the current index property
                // what index of the string am we at?
                let stringIndex = String.Index(utf16Offset: index, in: chosenWord)
                
                // increment the index property
                index += 1
                // compare the letter to the character we are at in the loop
                if letter == char {
                    // position of letter
                    // append the character's position to our string position array
                    indexArray.append(stringIndex)
                }
            }
            
            // loop through our string position array
            for index in indexArray {
                // insert the word at that position
                hangmanWordUpdated.insert(letter, at: index)
                // remove the offset _ from the string.
                hangmanWordUpdated.remove(at: hangmanWordUpdated.index(after: index))
            }
        }
        return hangmanWordUpdated
    }
    
    func createCorrectAnswerFeedback() -> String {
        // generate random number
        let randomNumber = Int.random(in: 0...FeedbackHelper.correct.count-1)
        
        let correctFeedback = FeedbackHelper.correct[randomNumber]
        return correctFeedback
    }
    
    func createWrongAnswerFeedback() -> String {
        // generate random number
        let randomNumber = Int.random(in: 0...FeedbackHelper.wrong.count-1)
        
        let wrongFeedback = FeedbackHelper.wrong[randomNumber]
        return wrongFeedback
    }
}

