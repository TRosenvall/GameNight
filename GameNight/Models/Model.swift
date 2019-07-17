//
//  Model.swift
//  GameNight
//
//  Created by Timothy Rosenvall on 7/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class Model {
    
    let property1: String
    let property2: Int
    let property3: Date
    let property4: [String]
    let property5: [Int: Date]
    
    init(property1: String, property2: Int, property3: Date = Date(), property4: [String], property5: [Int: Date]) {
        self.property1 = property1
        self.property2 = property2
        self.property3 = property3
        self.property4 = property4
        self.property5 = property5
    }
}
