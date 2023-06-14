//
//  MoneyView.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/13/23.
//

import SwiftUI

struct MoneyView: View {
    
    var money: Int
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            
            Text("\(money)")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .frame(height: 55)
        .background(
            RoundedRectangle(cornerRadius: 15)
            .fill(Color.red)
            )
    }
}

struct MoneyView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyView(money: 50)
    }
}
