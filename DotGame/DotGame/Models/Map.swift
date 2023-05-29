//
//  Map.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import Foundation

struct Dots {
    
    var owner: Participator
}

class Station {
    
    var owner: Participator?
    var position: (Int, Int)
    var ballsAmount: Int
    
    
    init(owner: Participator? = nil, position: (Int, Int), dotsAmount: Int) {
        self.owner = owner
        self.position = position
        self.ballsAmount = dotsAmount
    }
    
    func updateStation() {
        if owner == nil && ballsAmount < 10 { ballsAmount += 1 }
        else {
            if ballsAmount < 50 { ballsAmount += 1 }
        }
    }
}
