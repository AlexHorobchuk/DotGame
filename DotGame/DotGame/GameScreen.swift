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
        
        VStack() {
            
            GameProgress(stationColorData: game.stationColorData)
                .frame(height: 20)
                .padding(.top, 60)
            
            Spacer()
            
            ZStack {
                GameMapView(game: game)
                
                GeometryReader { gr in
                    GameSpriteView(viewModel: game, size: gr.size)
                        .frame(width: gr.size.width, height: gr.size.height)
                }
                .allowsHitTesting(false)
            }
            .fixedSize()
            
            Spacer()
        }
        .onAppear(perform: {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 1)) {
                        game.getColor()
                    }
                    game.updateMap()
                }
            }
        })
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
