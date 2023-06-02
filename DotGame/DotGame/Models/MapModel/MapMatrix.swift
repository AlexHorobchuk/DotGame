//
//  Map.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import Foundation

struct MapMatrix: Identifiable {
    
    var id = UUID()
    var name: String
    var player: Int
    var matrix: [[Int]]
}
