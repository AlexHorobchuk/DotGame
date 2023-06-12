//
//  GameOver.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/7/23.
//

import SwiftUI

struct GameOver: View {
    
    @State var animate = true
    @State var animateGreed = true
    @State var timer: Timer?
    
    var didWin: Bool
    
    var body: some View {
        ZStack {
            BackgroundView(animation: $animateGreed)
                .animation(.easeInOut(duration: 3))
            
            VStack {
                ScaledImage(
                    name: didWin ? "trophy.fill" : "hand.thumbsdown.fill",
                    size: .init(width: 80, height: 80)
                )
                .rotationEffect(animate ? Angle(degrees: -15) : Angle(degrees: 15))
                
                Text(didWin ? "VICTORY" : "DEFEAT")
                    .foregroundColor(.black)
                    .font(.system(size: 25,weight: .heavy))
                    .minimumScaleFactor(0.5)
                    .padding(.vertical, 25)
                
                RegularButton(animate: $animate, text: "Tap to Continue")
                    .scaleEffect(animate ? 0.8 : 1)
                
            }
            .frame(width: 300, height: 350)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 4))
        }
        .onAppear {
            SoundManager.shared.playSound(for: didWin ? .won : .loose)
            
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

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver(didWin: true)
    }
}
