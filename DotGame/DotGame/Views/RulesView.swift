//
//  RulesView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/12/23.
//

import SwiftUI

struct RulesView: View {
    
    
    var body: some View {
        VStack() {
            Text("Game Rules:")
                .font(.system(size: 24, weight: .semibold))
            
            VStack(alignment: .leading) {
                Text("- Your goal is to capture all computer stations")
                    .font(.system(size: 22, weight: .semibold))
                    .lineLimit(nil)
                    .padding()
                
                Text("- If you don't have any station, you lose")
                    .font(.system(size: 22, weight: .semibold))
                    .lineLimit(nil)
                    .padding()
                
                Text("- To move balls, just use a swipe")
                    .font(.system(size: 22, weight: .semibold))
                    .lineLimit(nil)
                    .padding()
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .frame(height: 320)
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
