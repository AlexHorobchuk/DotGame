//
//  MapGenerator.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class MapGenerator {
    
    func makeMapFromMatrix(mapMatrix: MapMatrix) -> [[Station]] {
        var map = Array(repeating: [Station](), count: mapMatrix.matrix.count)
        for (row, arr) in mapMatrix.matrix.enumerated() {
            for (col, val) in arr.enumerated() {
                let station = Station(type: val == 0 ? .empty : .active,
                                      owner: ParticipatorType(rawValue: val),
                                      position: (row, col),
                                      ballsAmount: ParticipatorType(rawValue: val) == nil ? 10 : 0)
                map[row].append(station)
            }
        }
        return map
    }
}
