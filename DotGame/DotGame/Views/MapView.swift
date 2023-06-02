//
//  MapView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct MapView: View {
    
    var stations : [[Station]]
    
    var body: some View {
        VStack(spacing: -16) {
            ForEach(stations.indices, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(stations[row]) { station in
                        HoneyCombView(station: station)
                    }
                }
            }
        }
    }
}
