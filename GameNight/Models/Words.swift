//
//  Words.swift
//  GameNight
//
//  Created by Julia Rodriguez on 7/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class Words {
    var words: [String]
    var trivialWord: String
    var feedbackArray: [String]
    var playerFeedback: String
    
    init(words: [String], trivialWord: String, feedbackArray: [String], playerFeedback: String) {
        
        self.words = words
        self.trivialWord = trivialWord
        self.feedbackArray = feedbackArray
        self.playerFeedback = playerFeedback
    }
    
    
}
