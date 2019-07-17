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
    
    // source of truth
    var words: [Words]?
    
}
