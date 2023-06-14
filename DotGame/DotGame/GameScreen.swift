//
//  ContentView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/28/23.
//

import SwiftUI

struct GameScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var progress: ProgressVM
    
    @StateObject var game : GameVM
    
    @State var timer: Timer?
    @State var botTimer: Timer?
    @State var showingSettings = false
    
    var body: some View {
        
        ZStack {
            if game.gameState == .rules || game.gameState == .preStart {
                PreGame(gameState: $game.gameState)
                    .onTapGesture {
                        SoundManager.shared.playSound(for: .click)
                        withAnimation(.easeInOut(duration: 1)) {
                            game.gameState = game.gameState.nextCase
                        }
                    }
                    .transition(.opacity)
            }
            
            if game.gameState == .rules {
                
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
                    self.timer = Timer.scheduledTimer(withTimeInterval: progress.getRegeneration(owner: .bot), repeats: true) { _ in
                        DispatchQueue.main.async {
                            game.getColor()
                            game.updateGame()
                        }
                    }
                    
                    self.botTimer = Timer.scheduledTimer(withTimeInterval: progress.getRegeneration(owner: .realPlayer), repeats: true) { _ in
                        DispatchQueue.main.async {
                            game.updateMap(for: .realPlayer)
                        }
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                    botTimer?.invalidate()
                }
                .transition(.opacity)
            }
            
            if game.gameState == .end {
                GameOver(didWin: game.didWin,
                         money: game.result ?? 0)
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    SoundManager.shared.playSound(for: .click)
                    showingSettings = true
                }) {
                    SettingsButton()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    SoundManager.shared.playSound(for: .click)
                    game.alert = AlertConfirmation.goBack
                }) {
                    CloseScreenButton()
                }
            }
        }
        .onReceive(game.$gameState) { gameState in
            if gameState == .end && game.result == nil {
                game.result = progress.getPrize(didWin: game.didWin)
            }
        }
        .alert(item: $game.alert) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  primaryButton: .destructive(Text("Yes"), action: {
                presentationMode.wrappedValue.dismiss()
            }) ,
                  secondaryButton: alert.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(progress: ProgressVM(), game:
                    GameVM(map: MapGenerator().makeMapFromMatrix(mapMatrix: AllMatrixManager.shared.getFirst()),
                           participators: [],
                           matrix: AllMatrixManager.shared.getFirst().matrix))
    }
}
