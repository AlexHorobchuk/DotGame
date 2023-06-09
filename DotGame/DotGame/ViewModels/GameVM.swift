//
//  GameVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

final class GameVM: ObservableObject {
    
    @Published var map: [[Station]]
    @Published var stationColorData: [Int: Int] = [:]
    @Published var participators: [Participator]
    @Published var gameState = GameState.preStart
    @Published var didWin = false
    var checkBalls: (() -> Set<ParticipatorType>)?
    
    var matrix: [[Int]]
    
    weak var logic: MoverService?
    
    init (map: [[Station]], participators: [Participator], matrix: [[Int]]) {
        self.map = map
        self.participators = participators
        self.matrix = matrix
        
        getColor()
        setParticipators()
    }
    
    init (gameInfo: GameInfo) {
        self.map = gameInfo.map
        self.participators = gameInfo.participators
        self.matrix = gameInfo.matrix
        
        getColor()
    }
    
    func getPlayer() -> Player? {
        return participators.first(where: { $0.type == .realPlayer }) as? Player
    }
    
    func stationTapped(station: Station) {
        if let player = getPlayer() {
            player.stationTapped(station: station)
        }
    }
    
    func isGameOver() {
        var owners: Set<ParticipatorType> = []
        for stationArray in map.compactMap({ $0 }) {
            for station in stationArray {
                guard let owner = station.owner else { continue }
                owners.insert(owner)
            }
        }
        guard owners.contains(.realPlayer) else {
            return DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    self.gameState = .end
                }
            }
        }
        
        if owners.count == 1 {
            let balls = checkBalls?()
            guard balls?.filter( {$0 != .realPlayer} ).count == 0 else { return }
            didWin = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    self.gameState = .end
                }
            }
        }
    }
    
    func stationDoubleTapped(station: Station) {
        if let player = getPlayer() {
            player.stationDoubleTapped(station: station)
        }
    }
    
    func clearPlayerStations() {
        if let player = getPlayer() {
            player.selectedStations = []
        }
    }
    
    func isSelected(station: Station) -> Bool {
        guard let player = getPlayer() else { return false }
        return player.selectedStations.contains(station)
    }
    
    func getColor() {
        var colorDict = [Int: Int]()
        for station in map.flatMap({ $0 }) {
            if station.owner == nil {
                colorDict[8, default: 0] += station.ballsAmount
            } else {
                let rawValue = station.owner!.rawValue
                colorDict[rawValue, default: 0] += station.ballsAmount
            }
        }
        stationColorData = colorDict
    }
    
    func stationAttacked(station: Station, by participator: ParticipatorType) {
        let needUpdate = station.underAttack(of: participator)
        if needUpdate {
            let player = findParticipator(type: .realPlayer)
            player.selectedStations.removeAll(where: { $0.id == station.id })
        }
    }
    
    func updateMap() {
        for i in map.indices {
            for j in map[i].indices {
                map[i][j].updateStation()
            }
        }
    }
    
    func setParticipators() {
        for participator in participators {
            participator.mover = logic
        }
    }
    
    func findParticipator(type: ParticipatorType) -> Participator {
        return participators.first(where: {$0.type == type})!
    }
    
    func setSelectedStations() {
        for station in map.flatMap({ $0 }) {
            if station.owner != .realPlayer && station.type == .active {
                guard let owner = station.owner else { continue }
                let participator = findParticipator(type: owner)
                participator.selectedStations.append(station)
            }
        }
    }
    
    func getBots() -> [BotPlayer] {
        return participators.compactMap { participator in
            if let botPlayer = participator as? BotPlayer, botPlayer.type != .realPlayer {
                return botPlayer
            }
            return nil
        }
    }
    
    func botsAttack() {
        for bot in getBots() {
            guard let station = bot.findStationToAttack(stations: map.flatMap({ $0 })) else { return }
            bot.attack(station: station)
            bot.clearStation()
        }
    }
    
    func updateGame() {
        updateMap()
        getColor()
        setSelectedStations()
        isGameOver()
        botsAttack()
    }
    
    func getStationByCoordinates(coordinates: Coordinate) -> Station? {
        return map.flatMap({ $0 }).first(where: { $0.position == coordinates })
    }
}
