//
//  MapButton.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/1/23.
//

import SwiftUI

struct MapButton: View {
    
    @Binding var animate: Bool
    var isSelected: Bool
    var matrix: MapMatrix
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.red)
                .shadow(color: .red ,radius: 5)
            
            if isSelected {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 5)
                    .fill(
                        LinearGradient(colors: [.blue, .orange , .yellow, .orange, .blue],
                                       startPoint: animate ? .leading : .trailing,
                                       endPoint: animate ? .trailing : .leading))
            }
            
            HStack {
                Text(matrix.name)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Divider()
                    .frame(width: 1)
                    .background(Color.white)
                    .padding(.vertical, 2)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.vertical, 15)
                
                Text("\(matrix.player)")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                
            }
            .padding(.horizontal)
        }
        .frame(width: 280, height: 55)
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton( animate: .constant(true), isSelected: true, matrix: MapMatrix(name: "One on One", player: 4, matrix: []))
    }
}
