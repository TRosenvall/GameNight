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
    
    //CRUD
    
    // Create 
    func createRandomWord() -> String {

        // generate randomn number
        let randomNumber = Int.random(in: 0...WordHelper.wordBank.count)
            
        let chosenWord = WordHelper.wordBank[randomNumber]
        return chosenWord

    }
    
    func createCorrectAnswerFeeback() -> String {
        // generate random number
        let randomNumber = Int.random(in: 0...FeedbackHelper.correct.count)
        
        let correctFeedback = FeedbackHelper.correct[randomNumber]
        return correctFeedback
        
    }
    func createWrongAnswerFeedback() -> String {
        
        // generate random number
        let randomNumber = Int.random(in: 0...FeedbackHelper.wrong.count)
        
        let wrongFeedback = FeedbackHelper.wrong[randomNumber]
        return wrongFeedback
    }
    func createHangManTemplate() -> String {
        
        var hangmanWord = ""
        
        let chosenWord = self.createRandomWord()
        
        for char in chosenWord {
            
            hangmanWord += "_"
        }
        return hangmanWord
    }
    
    // Update
    func updateHangManWord() -> String {
        
        let chosenWord = self.createRandomWord()
        var hangmanWordUpdated = self.createHangManTemplate()
        
        func fillInWord(letter: Character) {
            
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
        }
        return hangmanWordUpdated
    }
}
