//
//  HoneyCombView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

struct HoneyCombView: View {
    
    @ObservedObject var station: Station
    
    var body: some View {
        
        if station.type == .empty {
            Hexagon(radius: 10)
                .fill(.clear)
                .frame(width: 73, height: 73)
        }
        else {
            StationView(station: station)
        }
    }
}

struct HoneyCombView_Previews: PreviewProvider {
    static var previews: some View {
        HoneyCombView(station: Station(type: .empty, position: (1,1), ballsAmount: 20))
    }
}
