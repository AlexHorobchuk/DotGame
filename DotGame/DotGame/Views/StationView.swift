//
//  StationView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import SwiftUI

struct StationView: View {
    
    @ObservedObject var station: Station
    
    var body: some View {
        
        ZStack {
            Hexagon(radius: 10)
                .fill((station.owner == nil ? .gray : station.owner!.getParticipatorColor()))
                .opacity(0.5 + (Double(station.ballsAmount) * 0.01))
                
            VStack {
                Image(systemName: station.owner == nil ? "circle" : station.owner!.getParticipatorImage())
                    .font(.system(size: 24, weight: .heavy))
                    .opacity(0.6)
                
                Text("\(station.ballsAmount)")
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .frame(width: 73, height: 73)
        .animation(nil)
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        StationView(station: Station(type: .active, position: Coordinate(x: 1, y: 1), ballsAmount: 41))
    }
}
