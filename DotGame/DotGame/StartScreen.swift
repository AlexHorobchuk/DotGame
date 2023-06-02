//
//  StartView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct StartScreen: View {
    
    @StateObject var gameSetter = GameSetterVM(
        selectedMatrix: AllMatrixManager.shared.getFirst(),
        matrixs: AllMatrixManager.shared.matrix)
    
    @State var animate = true
    @State var animateGreed = true
    
    var body: some View {
        
        NavigationView {
            ZStack {
                BackgroundView(animation: $animateGreed)
                
                VStack(spacing: 40) {
                    
                    NavigationLink(destination:
                                    GameScreen(game: GameVM(map: gameSetter.playRandom(),
                                                             participators: gameSetter.participators))) {
                        RegularButton(animate: $animate, text: "START GAME")
                    }
                    
                    NavigationLink(destination:
                                    CustomGameScreen(gameSetter: gameSetter)) {
                        RegularButton(animate: $animate, text: "CUSTOM GAME")
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                        animate.toggle() }
                }
                
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 3.0).repeatForever()) {
                        animateGreed.toggle() }
                }
            }
        }
        .accentColor(.red)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
