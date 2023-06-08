//
//  extension.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import SwiftUI
import SpriteKit

extension GameScene: MoverService {
    
    func move(from stationA: Station, to stationB: Station, by participator: Participator) {
        guard let station = viewModel.getStationByCoordinates(coordinates: stationA.position) else { return }
        
        if station.owner == participator.type && station.ballsAmount > 0 {
            let maxBalls = station.getBallsForAttack()
            let sendAction = SKAction.run {
                for index in 0..<maxBalls {
                    self.sendBalls(index: index, maxBalls: maxBalls, from: stationA, to: stationB, by: participator)
                }
            }
            let repeatAction = SKAction.run { self.move(from: stationA, to: stationB, by: participator) }
            self.run(.sequence([sendAction, .wait(forDuration: 0.25), repeatAction]))
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node as? SKShapeNode else { return }
        guard let bodyB = contact.bodyB.node as? SKShapeNode else { return }
        bodyA.removeFromParent()
        bodyB.removeFromParent()
    }
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}

extension GameVM: Equatable {
    
    static func == (lhs: GameVM, rhs: GameVM) -> Bool {
        return lhs.map == rhs.map
    }
}

extension Station: Equatable {
    
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Color {
    
    static func random() -> Color {
        let randomRed = Double.random(in: 0...1)
        let randomGreen = Double.random(in: 0...1)
        let randomBlue = Double.random(in: 0...1)
        
        return Color(red: randomRed, green: randomGreen, blue: randomBlue)
    }
}

extension Participator: Hashable {
    
    static func == (lhs: Participator, rhs: Participator) -> Bool {
        return lhs.type == rhs.type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}
