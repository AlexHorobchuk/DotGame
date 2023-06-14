//
//  AllMatrix.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

class AllMatrixManager {
    
    static let shared = AllMatrixManager()
    
    var matrix: [MapMatrix]
    
    private init() {
        self.matrix = [MapMatrix(name: "Sweet Duo",
                                          player: 2,
                                          matrix: [[1, 2, 1], [ 1, 1], [1], [1, 1], [1,3,1]]),
                       MapMatrix(name: "Triange",
                                 player: 3,
                                 matrix: [[2], [1, 1], [3, 1, 4]]),
                       MapMatrix(name: "Zigzag",
                                 player: 3,
                                 matrix: [[1, 2, 1], [ 1, 0], [1, 3, 1], [0, 1], [1, 4, 1]]),
                       MapMatrix(name: "Diamond",
                                 player: 3,
                                 matrix: [[3, 1, 2], [1, 1, 1, 1], [1, 0, 1], [1, 1] ,[4]]),
                       MapMatrix(name: "Small Square",
                                 player: 4,
                                 matrix: [[2, 1, 3], [1, 1, 1, 1], [4, 1, 5]]),
                       MapMatrix(name: "Big Square",
                                 player: 4,
                                 matrix: [[2, 1, 1, 3], [1, 1, 1], [4, 1, 1, 5]]),
                       MapMatrix(name: "Donut",
                                 player: 4,
                                 matrix: [[1, 3, 1], [1, 0, 0, 1], [2, 0, 0, 0, 4], [1, 0, 0, 1], [1, 5, 1]]),
                       MapMatrix(name: "Cross",
                                 player: 4,
                                 matrix: [[1, 2, 3, 1], [1], [1, 1, 1, 1], [1], [4, 1, 1, 5]]),
                       MapMatrix(name: "Star",
                                 player: 6,
                                 matrix: [[ 6, 1], [1, 1, 1], [1, 3], [1, 1, 1], [5, 1, 1, 4], [1, 1, 1], [7, 1, 1, 2], [1, 1, 1]])]
        
        sortMatrixByPlayer()
    }
    
    private func sortMatrixByPlayer() {
        matrix = matrix.sorted { $0.player < $1.player }
    }
    
    func getFirst() -> MapMatrix {
        return matrix.first!
    }
    
    func getRandom() -> MapMatrix {
        return matrix.randomElement()!
    }
}
