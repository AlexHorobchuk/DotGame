//
//  Player.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class Player: Participator {
    
    init(stations: [Station]) {
        super.init(stations: stations, type: .realPlayer)
    }

    override func attack(station: Station) {
        guard selectedStations.isEmpty == false else { return }
        for selectedStation in selectedStations {
            mover?.move(from: selectedStation, to: station, by: self)
        }
    }
    
    func stationTapped(station: Station) {
        if station.type == .active {
            if station.owner == .realPlayer {
                guard selectedStations.contains(station) else { return selectedStations.append(station) }
                selectedStations.removeAll(where: { $0 == station })
            }
            else {
                attack(station: station)
            }
        }
    }
}
