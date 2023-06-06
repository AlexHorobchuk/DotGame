//
//  GameVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class GameVM: ObservableObject {
    
    @Published var map: [[Station]]
    @Published var stationColorData: [Int: Int] = [:]
    @Published var participators: [Participator]
    
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
    
    func updateGame() {
        updateMap()
        getColor()
    }
}
