//
//  SwiftUIView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct CustomGameScreen: View {
    
    @ObservedObject var gameSetter: GameSetterVM
    
    @State var animation = true
    @State var animateGreed = true
    
    var body: some View {
        
        ZStack {
            BackgroundView(animation: $animateGreed)
            
            VStack {
                TextView(text: "CUSTOM GAME", fontSize: 26)
                    .padding(.top, 30)
                
                MapSample(map: gameSetter.makeSelectedMap())
                    .padding()
                
                ScrollView {
                    ForEach(gameSetter.matrixs) { matrix in
                        Button(action: { gameSetter.selectMatrix(matrix) } ,
                               label: {
                            MapButton(animate: $animation,
                                      isSelected: matrix.id == gameSetter.selectedMatrix.id,
                                      matrix: matrix)
                               .padding(5)
                        })
                    }
                }
                .frame(height: 270)
                
                NavigationLink(destination:
                                GameScreen(game: GameVM(map: gameSetter.makeSelectedMap(),
                                                        participators: gameSetter.participators)),
                       label: {
                    RegularButton(animate: $animation,
                                  text: "START")
                    .scaleEffect(animation ? 0.8 : 1)
                })
                .padding()
                
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                    animation.toggle() }
            }
            
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 3.0).repeatForever()) {
                    animateGreed.toggle() }
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
