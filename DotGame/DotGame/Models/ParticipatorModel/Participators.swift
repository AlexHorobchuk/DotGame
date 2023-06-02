//
//  Participators.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import Foundation

class Participator {
    
    var stations: [Station]
    var mover: MoverService?
    var type: ParticipatorType

    init(stations: [Station], type: ParticipatorType) {
        self.stations = stations
        self.type = type
    }
    
    func attack(station: Station) {}
}

