//
//  Participators.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import Foundation

class Participator {
    
    var stations: [Station]
    var mover: MoverService

    init(stations: [Station], mover: MoverService) {
        self.stations = stations
        self.mover = mover
    }
    
    func attack(station: Station) {}
}

class Player: Participator {
    
    var selectedStation: Station?
    
    override init(stations: [Station], mover: MoverService) {
        super.init(stations: stations, mover: mover)
    }

    override func attack(station: Station) {
        guard let selectedStation = selectedStation, selectedStation.ballsAmount > 0 else { return }
        mover.move(ballsQountity: selectedStation.ballsAmount, from: selectedStation, to: station, by: self)
    }
}

class BotPlayer: Participator {
    
    override init(stations: [Station], mover: MoverService) {
        super.init(stations: stations, mover: mover)
    }
    
    private func makeDecision() -> Bool {
        return [true, false, false].randomElement()!
    }

    override func attack(station: Station) {
        if makeDecision() {
            
        }
    }
}
