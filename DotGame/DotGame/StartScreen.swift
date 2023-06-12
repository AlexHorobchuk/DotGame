//
//  StartView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct StartScreen: View {
    
    @StateObject var gameSetter = GameSetterVM(
        selectedMatrix: AllMatrixManager.shared.getRandom(),
        matrixs: AllMatrixManager.shared.matrix)
    
    @State var animate = true
    @State var animateGreed = true
    @State var timer: Timer?
    @State var showingSettings = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                BackgroundView(animation: $animateGreed)
                    .animation(.easeInOut(duration: 3))
                
                VStack(spacing: 40) {
                    
                    NavigationLink(destination:
                                    GameScreen(game:
                                                GameVM(gameInfo: gameSetter.getGameInfo(for: .random)))) {
                        RegularButton(animate: $animate, text: "START GAME")
                    }
                                                .simultaneousGesture(TapGesture().onEnded {
                                                    SoundManager.shared.playSound(for: .click)
                                                })
                    
                    NavigationLink(destination:
                                    CustomGameScreen(gameSetter: gameSetter)) {
                        RegularButton(animate: $animate, text: "CUSTOM GAME")
                    }
                                    .simultaneousGesture(TapGesture().onEnded {
                                        SoundManager.shared.playSound(for: .click)
                                    })
                    
                    Link(destination: URL(string: "https://www.apple.com")!) {
                        RegularButton(animate: $animate, text: "PRIVACY POLICY")
                            .simultaneousGesture(TapGesture().onEnded {
                                SoundManager.shared.playSound(for: .click)
                            })
                    }
                }
            }
            .onAppear {
                MusicManager.shared.playBackgroundMusic()
                
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 2).repeatForever()) {
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
        .accentColor(.red)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
