//
//  GameSetterVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

final class GameSetterVM: ObservableObject {
    
    @Published var selectedMatrix: MapMatrix
    
    var participators: [Participator] = []
    var matrixs: [MapMatrix]
    
    init(selectedMatrix: MapMatrix, matrixs: [MapMatrix]) {
        self.selectedMatrix = selectedMatrix
        self.matrixs = matrixs
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
        for (row, arr) in mapMatrix.matrix.enumerated() {
            for (col, val) in arr.enumerated() {
                let station = Station(type: val == 0 ? .empty : .active,
                                      owner: ParticipatorType(rawValue: val),
                                      position: Coordinate(x: col, y: row),
                                      ballsAmount: ParticipatorType(rawValue: val) == nil ? 10 : 0)
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
