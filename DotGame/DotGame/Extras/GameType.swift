//
//  GameType.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/3/23.
//

import Foundation

enum GameType {
    case random, custom
}

enum GameState {
    case preStart, rules , start, end
    
    var nextCase: GameState {
        let allCases: [GameState] = [.rules, .preStart, .start, .end]
        guard let currentIndex = allCases.firstIndex(of: self) else {
            return self
        }
        let nextIndex = (currentIndex + 1)
        return allCases[nextIndex]
    }
}
