//
//  GameMapView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/4/23.
//

import SwiftUI

struct GameMapView: View {
    
    @ObservedObject var game: GameVM
    
    var body: some View {
        VStack(spacing: -16) {
            ForEach(game.map.indices, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(game.map[row]) { station in
                        HoneyCombView(station: station)
                            .overlay(
                                Hexagon(radius: 10)
                                    .stroke(Color.red,
                                            lineWidth: game.isSelected(station: station) && station.owner == .realPlayer ? 2 : 0)
                                    .frame(width: 72, height: 72)
                            )
                            .clipShape(Hexagon(radius: 10))
                    }
                }
            }
        }
    }
}

struct GameMapView_Previews: PreviewProvider {
    static var previews: some View {
        GameMapView(game: GameVM(map: MapGenerator().makeMapFromMatrix(mapMatrix: AllMatrixManager.shared.getFirst()),
                                 participators: [],
                                 matrix: AllMatrixManager.shared.getFirst().matrix))
    }
}
