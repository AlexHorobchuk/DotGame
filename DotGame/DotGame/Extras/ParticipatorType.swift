//
//  ParticipatorType.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

enum ParticipatorType: Int, RawRepresentable, CaseIterable {
    
    case realPlayer = 2 , one, two, three, four, five
    
    func getParticipator(stations: [Station]) -> Participator {
        switch self {
            
        case .realPlayer:
            return Player(stations: [])
        default:
            return BotPlayer(stations: [], type: self)
        }
    }
    
    func getParticipatorColor() -> Color {
        switch self {
            
        case .one:
            return Color.green
        case .two:
            return Color.red
        case .three:
            return Color.purple
        case .four:
            return Color.yellow
        case .five:
            return Color.orange
        case .realPlayer:
            return Color.blue
        }
    }
    
    func getParticipatorImage() -> String {
        switch self {
            
        case .one:
            return "fish.fill"
        case .two:
            return "tortoise.fill"
        case .three:
            return "lizard.fill"
        case .four:
            return "bird.fill"
        case .five:
            return "ant.fill"
        case .realPlayer:
            return "hare.fill"
        }
    }
    
    func getMyBitMask() -> UInt32 {
        switch self {
            
        case .realPlayer:
            return 2
        case .one:
            return 4
        case .two:
            return 8
        case .three:
            return 16
        case .four:
            return 32
        case .five:
            return 64
        }
    }
    
    func getEnemysBitsMask() -> UInt32 {
        var combinedBitmask: UInt32 = 0

        for case let enemyCase in ParticipatorType.allCases where enemyCase != self {
            combinedBitmask |= enemyCase.getMyBitMask()
        }

        return combinedBitmask
    }
}
