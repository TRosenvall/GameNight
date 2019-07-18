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
    
    
    
}
