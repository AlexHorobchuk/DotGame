//
//  extension.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import SwiftUI

extension GameScene: MoverService {
    
    func move(ballsQountity: Int, from stationA: Station, to stationB: Station, by: Participator) {
        
    }
}

extension GameVM: Equatable {
    
    static func == (lhs: GameVM, rhs: GameVM) -> Bool {
        return lhs.map == rhs.map
    }
}

extension Station: Equatable {
    
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.owner == rhs.owner && lhs.ballsAmount == rhs.ballsAmount
    }
}

extension Color {
    
    static func random() -> Color {
        let randomRed = Double.random(in: 0...1)
        let randomGreen = Double.random(in: 0...1)
        let randomBlue = Double.random(in: 0...1)
        
        return Color(red: randomRed, green: randomGreen, blue: randomBlue)
    }
}

extension Participator: Hashable {
    
    static func == (lhs: Participator, rhs: Participator) -> Bool {
        return lhs.type == rhs.type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}
