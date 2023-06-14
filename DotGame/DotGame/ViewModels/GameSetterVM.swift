//
//  GameSetterVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

final class GameSetterVM: ObservableObject {
    
    @Published var selectedMatrix: MapMatrix
    @Published var progressVM: ProgressVM
    
    var participators: [Participator] = []
    var matrixs: [MapMatrix]
    
    init(selectedMatrix: MapMatrix, matrixs: [MapMatrix], progressVM: ProgressVM) {
        self.selectedMatrix = selectedMatrix
        self.matrixs = matrixs
        self.progressVM = progressVM
    }
    
    func makeSelectedMap() -> [[Station]] {
        return makeMapAndParticipators(mapMatrix: selectedMatrix)
    }
    
    func selectMatrix(_ matrix: MapMatrix) {
        self.selectedMatrix = matrix
    }
    
    func setFirstMatrix() {
        DispatchQueue.main.async {
            self.selectedMatrix = self.matrixs.first ??  MapMatrix(name: "One on One", player: 2, matrix: [[2, 1, 3]])
        }
    }
    
    func playRandom() -> [[Station]] {
        DispatchQueue.main.async {
            self.selectedMatrix = self.matrixs.randomElement() ?? MapMatrix(name: "One on One", player: 2, matrix: [[2, 1, 3]])
        }
        return makeSelectedMap()
    }
    
    func getGameInfo(for type: GameType) -> GameInfo {
        return GameInfo(map: type == .random ? playRandom() : makeSelectedMap(),
                        participators: participators,
                        matrix: selectedMatrix.matrix)
    }
    
    func makeMapAndParticipators(mapMatrix: MapMatrix) -> [[Station]] {
        var map = Array(repeating: [Station](), count: mapMatrix.matrix.count)
        let maxRecovery = progressVM.getStationMaxRecovery()
        for (row, arr) in mapMatrix.matrix.enumerated() {
            for (col, val) in arr.enumerated() {
                let participator = ParticipatorType(rawValue: val)
                let startBalls = progressVM.getStationStart(owner: participator)
                let station = Station(type: val == 0 ? .empty : .active,
                                      owner: participator,
                                      position: Coordinate(x: col, y: row),
                                      ballsAmount: startBalls,
                                      maxRecovery: maxRecovery,
                                      startBalls: startBalls)
                map[row].append(station)
                makeParticipators(station: station, value: val)
            }
        }
        return map
    }
    
    func makeParticipators(station: Station, value: Int) {
        guard let participatorType = ParticipatorType(rawValue: value) else { return }
        participators.append(participatorType.getParticipator(stations: [station]))
        
    }
}
