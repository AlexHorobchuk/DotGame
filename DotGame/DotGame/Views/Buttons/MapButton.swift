//
//  MapButton.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/1/23.
//

import SwiftUI

struct MapButton: View {
    
    @State var animate = true
    var isSelected: Bool
    var matrix: MapMatrix
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.red)
                .shadow(color: isSelected ? .blue : .red ,radius: 5)
            
            if isSelected {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
                    .fill(Color.blue)
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
        .onAppear(perform: {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                    animate.toggle()
                }
            }
        })
        .frame(width: 280, height: 55)
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton( isSelected: true, matrix: MapMatrix(name: "One on One", player: 4, matrix: []))
    }
}
