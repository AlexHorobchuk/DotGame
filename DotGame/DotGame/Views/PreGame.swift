//
//  PreGame.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/7/23.
//

import SwiftUI

struct PreGame: View {
    
    @State var animate = true
    @State var animateGreed = true
    @State var timer: Timer?
    
    let station = Station(type: .active,
                          owner: .realPlayer ,
                          position: .init(x: 0, y: 0),
                          ballsAmount: 10)
    
    var body: some View {
        
        ZStack {
            BackgroundView(animation: $animateGreed)
                .animation(.easeInOut(duration: 3))
            
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
                
                RegularButton(animate: $animate, text: "Tap to Continue")
                    .scaleEffect(animate ? 0.8 : 1)
                
            }
            .frame(width: 300, height: 500)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 4))
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                    animate.toggle()
                }
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                DispatchQueue.main.async {
                        animateGreed.toggle()
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

struct PreGame_Previews: PreviewProvider {
    static var previews: some View {
        PreGame()
    }
}
