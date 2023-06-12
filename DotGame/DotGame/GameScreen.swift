//
//  ContentView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/28/23.
//

import SwiftUI

struct GameScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var game : GameVM
    
    @State var timer: Timer?
    @State var showingSettings = false
    
    var body: some View {
        
        ZStack {
            if game.gameState == .preStart {
                PreGame()
                    .ignoresSafeArea()
                    .onTapGesture {
                        SoundManager.shared.playSound(for: .click)
                        withAnimation(.easeInOut(duration: 1)) {
                            game.gameState = .start
                        }
                    }
                    .transition(.opacity)
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
                .transition(.opacity)
            }
            
            if game.gameState == .end {
                GameOver(didWin: game.didWin)
                    .onTapGesture {
                        SoundManager.shared.playSound(for: .click)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .transition(.opacity)
            }
        }
        .fullScreenCover(isPresented: $showingSettings) {
            SettingsView(isShowingSettings: $showingSettings)
                .clearModalBackground()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    SoundManager.shared.playSound(for: .click)
                    showingSettings = true
                }) {
                    SettingsButton()
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
