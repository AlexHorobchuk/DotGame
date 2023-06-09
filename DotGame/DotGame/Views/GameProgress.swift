//
//  GameProgress.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/1/23.
//

import SwiftUI

struct GameProgress: View {
    var stationColorData: [Int: Int]
    
    var body: some View {
        
        let totalAmount = stationColorData.values.reduce(0, +)
        let ratio = 250.0 / CGFloat(totalAmount)
        
        HStack(spacing: 2) {
            ForEach(2..<9) { participator in
                if let amount = stationColorData[participator] {
                    if amount > 0 {
                        Rectangle()
                            .fill(ParticipatorType(rawValue: participator) == nil ?
                                  Color.gray :
                                    ParticipatorType(rawValue: participator)!.getParticipatorColor())
                            .frame(width: CGFloat(amount) * ratio)
                    }
                }
            }
        }
        .frame(width: 250)
        .mask(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .white ,radius: 5)
    }
}

struct GameProgress_Previews: PreviewProvider {
    static var previews: some View {
        GameProgress(stationColorData: [2: 10, 4: 40, 5: 50, 8: 70])
    }
}
