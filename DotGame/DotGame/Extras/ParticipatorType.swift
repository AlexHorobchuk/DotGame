//
//  ParticipatorType.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

enum ParticipatorType: Int, RawRepresentable {
    
    case realPlayer = 2 , one, two, three, four, five
    
    func getParticipator(stations: [Station]) -> Participator {
        switch self {
            
        case .realPlayer:
            return Player(stations: stations)
        default:
            return BotPlayer(stations: stations, type: self)
        }
    }
    
    func getParticipatorColor() -> Color {
        switch self {
            
        case .one:
            return Color.pink
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
}
