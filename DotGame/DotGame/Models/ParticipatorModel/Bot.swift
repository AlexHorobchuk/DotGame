//
//  Bot.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class BotPlayer: Participator {
    
    override init(stations: [Station], type: ParticipatorType) {
        super.init(stations: stations, type: type)
    }
    
    private func makeDecision() -> Bool {
        return [true, false, false].randomElement()!
    }

    override func attack(station: Station) {
        if makeDecision() {
            
        }
    }
}
