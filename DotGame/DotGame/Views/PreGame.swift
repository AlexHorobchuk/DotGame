//
//  PreGame.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/7/23.
//

import SwiftUI

struct PreGame: View {
    
    @State var animate = true
    
    let station = Station(type: .active,
                          owner: .realPlayer ,
                          position: .init(x: 0, y: 0),
                          ballsAmount: 10)
    
    var body: some View {
        ZStack {
            GameBackground()
            
            VStack {
                Text(" Your station is: ")
                    .font(.system(size: 24, weight: .semibold))
                
                HoneyCombView(station: station)
                    .scaleEffect(1.5)
                    .padding(30)
                
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 50))
                        .offset(x: animate ? 30 : -20)
                    
                }
                .padding()
                
                Text("Tap to Continue")
                    .foregroundColor(.red)
                    .font(.system(size: 24, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(nil)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue.opacity(0.5)))
                    .scaleEffect(animate ? 1 : 0.9)
                
            }
            .frame(width: 300, height: 500)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 4))
        }
        .onAppear{
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                    animate.toggle()
                }
            }
        }
    }
}

struct PreGame_Previews: PreviewProvider {
    static var previews: some View {
        PreGame()
    }
}
