//
//  SwiftUIView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct BackgroundView: View {
    
    @Binding var animation: Bool
    
    private func getHexagonColor(row: Int, column: Int) -> Color {
        let colors: [Color] = [ .red, .pink, .blue, .green, .orange, .purple]
        if Int.random(in: 1...4) != 3 {
            return .gray
        } else {
            return animation ? .white :  Bool.random() ? .clear : colors.randomElement()!
        }
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                VStack(spacing: -17) {
                    
                    ForEach(1..<18, id: \.self) { row in
                        
                        let col = row % 2 == 0 ? 7 : 8
                        
                        HStack(spacing: 5) {
                            ForEach(0..<col, id: \.self) { column in
                                Hexagon(radius: 10)
                                    .fill(getHexagonColor(row: row, column: column))
                                    .frame(width: 73, height: 73)
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(animation: .constant(true))
    }
}
