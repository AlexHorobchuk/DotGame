//
//  ContentView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/28/23.
//

import SwiftUI

struct GameScreen: View {
    
    @StateObject var game : GameVM
    
    @State var timer: Timer?
    
    var body: some View {
        
        ZStack {
            if game.gameState == .preStart {
                PreGame()
                    .ignoresSafeArea()
                    .onTapGesture {
                        game.gameState = .start
                    }
            }
            
            if game.gameState == .start {
                VStack {
                    
                    GameProgress(stationColorData: game.stationColorData)
                        .frame(height: 20)
                        .padding(.top, 60)
                        .animation(.easeInOut(duration: 0.5))
                    
                    Spacer()
                    
                    ZStack {
                        GameMapView(game: game)
                            .animation(nil)
                        
                        GeometryReader { gr in
                            GameSpriteView(viewModel: game, size: gr.size)
                                .frame(width: gr.size.width, height: gr.size.height)
                        }
                    }
                    .fixedSize()
                    
                    Spacer()
                }
                .onAppear {
                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                        DispatchQueue.main.async {
                            game.getColor()
                            game.updateGame()
                        }
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(game:
                    GameVM(map: MapGenerator().makeMapFromMatrix(mapMatrix: AllMatrixManager.shared.getFirst()),
                           participators: [],
                           matrix: AllMatrixManager.shared.getFirst().matrix))
    }
}
