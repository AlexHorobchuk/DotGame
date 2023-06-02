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
        
        VStack {
            ZStack {
                MapView(stations: game.map)
                
                GeometryReader { gr in
                    GameSpriteView(viewModel: game, size: .zero)
                        .frame(width: gr.size.width, height: gr.size.height)
                        .onAppear(perform: { print(gr.size) })
                }
            }
            .fixedSize()
        }
        .onAppear(perform: {
            print(game.participators)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                for i in game.map.indices {
                    for j in game.map[i].indices {
                        game.map[i][j].updateStation()
                    }
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(game: GameVM(map: MapGenerator().makeMapFromMatrix(mapMatrix: AllMatrixManager.shared.getFirst()), participators: []))
    }
}
