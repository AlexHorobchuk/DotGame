//
//  TextView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/31/23.
//

import SwiftUI

struct TextView: View {
    
    var text: String
    var fontSize: CGFloat
    
    var body: some View {
        
        Text(text)
            .foregroundColor(.white)
            .font(.system(size: fontSize, weight: .bold))
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.red))
    }
}
