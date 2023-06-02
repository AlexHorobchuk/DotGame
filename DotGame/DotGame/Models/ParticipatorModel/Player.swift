//
//  Player.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class Player: Participator {
    
    var selectedStation: Station?
    
    init(stations: [Station]) {
        super.init(stations: stations, type: .realPlayer)
    }

    override func attack(station: Station) {
        guard let selectedStation = selectedStation, selectedStation.ballsAmount > 0 else { return }
        mover?.move(ballsQountity: selectedStation.ballsAmount, from: selectedStation, to: station, by: self)
    }
    
    func stationTapped(station: Station) {
        guard station.owner == self.type else { return selectedStation = station }
        attack(station: station)
    }
}
