//
//  MapSample.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/1/23.
//

import SwiftUI

struct MapSample: View {
    
    var map: [[Station]]
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 5)
            .fill(.red)
            .frame(width: 250, height: 300)
            .overlay(
                MapView(stations: map)
                    .scaleEffect(0.5))
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white.opacity(0.95)))
    }
}
