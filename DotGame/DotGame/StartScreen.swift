//
//  StartView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct StartScreen: View {
    
    @ObservedObject var gameSetter: GameSetterVM
    @ObservedObject var progressVM: ProgressVM
    
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
                                    GameScreen(progress: gameSetter.progressVM,
                                               game:
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
                    
                    Button(action: {
                        showingSettings = true
                    }) {
                        RegularButton(animate: $animate, text: "SETTINGS")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        SoundManager.shared.playSound(for: .click)
                    })
                    
                    Button(action: {
                        progressVM.buy(item: .stationStart)
                    }) {
                        BuyButton(animate: $animate,
                                  itemType: .stationStart,
                                  price: progressVM.getPriceFor(item: .stationStart))
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        SoundManager.shared.playSound(for: .click)
                    })

                    Button(action: {
                        progressVM.buy(item: .regeneration)
                    }) {
                        BuyButton(animate: $animate,
                                  itemType: .regeneration,
                                  price: progressVM.getPriceFor(item: .regeneration))
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        SoundManager.shared.playSound(for: .click)
                    })
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
                    MoneyView(money: progressVM.money)
                        .scaleEffect(0.8)
                }
            }
            .alert(item: $progressVM.alert) { alert in
                Alert(title: alert.title,
                          message: alert.message,
                          dismissButton: alert.dismissButton)
            }
        }
        .accentColor(.red)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen(gameSetter: GameSetterVM(
            selectedMatrix: AllMatrixManager.shared.getRandom(),
            matrixs: AllMatrixManager.shared.matrix, progressVM: ProgressVM()), progressVM: ProgressVM())
    }
}
