//
//  RegularButton.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct RegularButton: View {
    
    @Binding var animate: Bool
    
    var text: String
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.red)
                .shadow(color: .red ,radius: 15)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 5)
                .fill(
                    LinearGradient(colors: [.blue, .orange , .yellow, .orange, .blue],
                                     startPoint: animate ? .leading : .trailing,
                                     endPoint: animate ? .trailing : .leading))
            
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
        }
        .frame(width: 200, height: 55)
    }
}

struct RegularButton_Previews: PreviewProvider {
    static var previews: some View {
        RegularButton(animate: .constant(true), text: "Hello")
    }
}
