//
//  GameBackground.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/7/23.
//

import SwiftUI

struct GameBackground: View {
    
    var body: some View {
        
        VStack {
            ZStack {
                VStack(spacing: -15) {
                    
                    ForEach(1..<17, id: \.self) { row in
                        
                        let col = row % 2 == 0 ? 7 : 8
                        
                        HStack(spacing: 5) {
                            ForEach(0..<col, id: \.self) { column in
                                Hexagon(radius: 10)
                                    .stroke(Color.black, lineWidth: 4)
                                    .frame(width: 73, height: 73)
                                    .mask(Hexagon(radius: 10))
                            }
                        }
                    }
                }
            }
        }
        .fixedSize()
        .frame(maxWidth: UIScreen.main.bounds.width,
               maxHeight: UIScreen.main.bounds.height)
    }
}

struct GameBackground_Previews: PreviewProvider {
    static var previews: some View {
        GameBackground()
    }
}
