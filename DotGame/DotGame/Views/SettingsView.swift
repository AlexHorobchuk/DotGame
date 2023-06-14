//
//  SettingsView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/8/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isShowingSettings: Bool
    
    @State var animate = true
    @State var musicOn: Bool = UserDefaultsManager.shared.isMusicEnabled
    @State var soundOn: Bool = UserDefaultsManager.shared.isSoundEnabled
    @State var vibrationOn: Bool = UserDefaultsManager.shared.isVibrationEnabled
    
    
    var body: some View {
        
        VStack {
            VStack {
                ZStack {
                    GameBackground()
                    
                    VStack(spacing: 30) {
                        HStack {
                            TextView(text: "Music", fontSize: 24)
                            
                            Spacer()
                            
                            Button(action: {
                                SoundManager.shared.playSound(for: .click)
                                UserDefaultsManager.shared.isMusicEnabled.toggle()
                                MusicManager.shared.playBackgroundMusic()
                                musicOn.toggle()
                            }) {
                                ManagerButton(animate: $animate, text: musicOn ? "ON" : "OFF")
                                    .frame(width: 60)
                            }
                        }
                        
                        HStack {
                            TextView(text: "Sound", fontSize: 24)
                            
                            Spacer()
                            
                            Button(action: {
                                UserDefaultsManager.shared.isSoundEnabled.toggle()
                                SoundManager.shared.playSound(for: .click)
                                soundOn.toggle()
                            }) {
                                ManagerButton(animate: $animate, text: soundOn ? "ON" : "OFF")
                                    .frame(width: 60)
                            }
                        }
                        
                        HStack {
                            TextView(text: "Vibration", fontSize: 24)
                            
                            Spacer()
                            
                            Button(action: {
                                UserDefaultsManager.shared.isVibrationEnabled.toggle()
                                VibrationManager.shared.vibrate(for: .medium)
                                SoundManager.shared.playSound(for: .click)
                                vibrationOn.toggle()
                            }) {
                                ManagerButton(animate: $animate, text: vibrationOn ? "ON" : "OFF")
                                    .frame(width: 60)
                            }
                        }
                        
                        Link(destination: URL(string: "https://www.apple.com")!) {
                            RegularButton(animate: $animate, text: "PRIVACY POLICY")
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            SoundManager.shared.playSound(for: .click)
                        })
                        
                        Button(action: {
                            SoundManager.shared.playSound(for: .click)
                            isShowingSettings = false
                        }) {
                            RegularButton(animate: $animate, text: "Done")
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(.horizontal, 10)
                    .fixedSize()
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75, maxHeight: UIScreen.main.bounds.height * 0.75)
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .ignoresSafeArea(edges: .top)
        }
        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 2).repeatForever()) {
                    animate.toggle()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isShowingSettings: .constant(true))
    }
}
