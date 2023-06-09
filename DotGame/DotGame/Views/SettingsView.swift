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
    
    var body: some View {
        
        VStack {
            VStack {
                ZStack {
                    GameBackground()
                    
                    VStack(spacing: 30) {
                        HStack {
                            TextView(text: "Music", fontSize: 24)
                            
                            Spacer()
                            
                            Button(action: {  }) {
                                ManagerButton(animate: $animate, text: "OFF")
                                    .frame(width: 60)
                            }
                        }
                        
                        HStack {
                            TextView(text: "Sound", fontSize: 24)
                            
                            Spacer()
                            
                            Button(action: {  }) {
                                ManagerButton(animate: $animate, text: "OFF")
                                    .frame(width: 60)
                            }
                        }
                        
                        HStack {
                            TextView(text: "Vibration", fontSize: 24)
                            
                            Spacer()
                            
                            Button(action: {  }) {
                                ManagerButton(animate: $animate, text: "OFF")
                                    .frame(width: 60)
                            }
                        }
                        
                        Button(action: { isShowingSettings = false }) {
                            RegularButton(animate: $animate, text: "Done")
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(.horizontal, 10)
                    .fixedSize()
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75, maxHeight: UIScreen.main.bounds.height * 0.65)
            .background(Color.black.opacity(0.85))
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
