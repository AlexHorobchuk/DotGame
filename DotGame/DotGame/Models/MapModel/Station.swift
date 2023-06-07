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
    
    func getBallsForAttack() -> Int {
        var ballsForAttack = 0
        if ballsAmount > 5 {
            ballsForAttack = 5
        }
        else {
            ballsForAttack = ballsAmount
        }
        ballsAmount -= ballsForAttack
        return ballsForAttack
    }
    
    func underAttack(of participator: ParticipatorType) -> Bool {
        var needUpdate = false
        if participator == owner {
            ballsAmount += 1
        }
        else {
            if ballsAmount == 0 {
                if owner == .realPlayer {
                    needUpdate = true
                }
                owner = participator
            }
            else {
                ballsAmount -= 1
            }
            
        }
        return needUpdate
    }
}
