//
//  StationVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

class Station: Identifiable, ObservableObject {
  
    @Published var type: StationType
    @Published var owner: ParticipatorType?
    @Published var ballsAmount: Int
    
    var position: Coordinate
    var id = UUID()
    
    init(type: StationType, owner: ParticipatorType? = nil, position: Coordinate, ballsAmount: Int) {
        self.type = type
        self.owner = owner
        self.position = position
        self.ballsAmount = ballsAmount
    }
    
    func updateStation() {
        guard type == .active else { return }
        if owner == nil && ballsAmount < 10 { ballsAmount += 1 }
        else {
            if owner != nil && ballsAmount < 50 { ballsAmount += 1 }
        }
    }
}
