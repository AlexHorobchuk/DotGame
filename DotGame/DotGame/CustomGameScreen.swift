//
//  SwiftUIView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct CustomGameScreen: View {
    
    @ObservedObject var gameSetter: GameSetterVM
    
    @State var animate = true
    @State var animateGreed = true
    @State var timer: Timer?
    @State var showingSettings = false
    
    var body: some View {
        
        ZStack {
            BackgroundView(animation: $animateGreed)
                .animation(.easeInOut(duration: 3))
            
            VStack {
                TextView(text: "CUSTOM GAME", fontSize: 26)
                    .padding(.top, 40)
                
                MapSample(map: gameSetter.makeSelectedMap())
                    .padding()
                
                ScrollView {
                    ForEach(gameSetter.matrixs) { matrix in
                        Button(action: { gameSetter.selectMatrix(matrix) } ,
                               label: {
                            MapButton(
                                      isSelected: matrix.id == gameSetter.selectedMatrix.id,
                                      matrix: matrix)
                               .padding(5)
                        })
                    }
                }
                .frame(height: 270)
                .frame(maxWidth: UIScreen.main.bounds.width)
                
                
                NavigationLink(destination: {
                    GameScreen(game:
                                GameVM(gameInfo: gameSetter.getGameInfo(for: .custom)))}
                               ,
                               label: {
                    RegularButton(animate: $animate,
                                  text: "START")
                    .scaleEffect(animate ? 0.8 : 1)
                })
                .padding()
                
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                gameSetter.selectedMatrix = gameSetter.matrixs.first!
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
        
        .fullScreenCover(isPresented: $showingSettings) {
            SettingsView(isShowingSettings: $showingSettings)
                .clearModalBackground()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingSettings = true
                }) {
                    SettingsButton()
                }
                
            }
        }
    }
}

struct Custongame_Preview: PreviewProvider {
    static var previews: some View {
        CustomGameScreen(gameSetter: GameSetterVM(selectedMatrix: AllMatrixManager.shared.getFirst(),
                                            matrixs: AllMatrixManager.shared.matrix))
    }
}
