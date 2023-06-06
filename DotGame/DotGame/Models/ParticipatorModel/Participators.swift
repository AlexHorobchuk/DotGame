//
//  Participators.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import Foundation

class Participator: ObservableObject {
    
    @Published var selectedStations: [Station] = []
    
    var mover: MoverService?
    var type: ParticipatorType

    init(stations: [Station], type: ParticipatorType) {
        self.type = type
    }
    
    func attack(station: Station) {}
}

