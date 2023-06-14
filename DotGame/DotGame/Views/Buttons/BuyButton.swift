//
//  BuyButton.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/13/23.
//

import SwiftUI

struct BuyButton: View {
    
    @Binding var animate: Bool
    
    var itemType: ItemType
    var price: Int
    func getImage() -> String {
        return itemType == .regeneration ?
        "person.badge.clock.fill" : "person.fill.badge.plus"
    }
    
    func getSign() -> String {
        return itemType == .regeneration ?
        "PRODUCE SPEED" : "START UNITS"
    }
    
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
            HStack {
                Image(systemName: getImage())
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                
                Divider()
                    .frame(width: 1)
                    .background(Color.white)
                    .padding(.vertical, 2)
                
                Spacer()
                
                Text(getSign())
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .frame(width: 1)
                    .background(Color.white)
                    .padding(.vertical, 2)
                
                Spacer()
                
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                    
                    Text("\(price)")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 80)
            }
            .animation(nil)
            .padding(.horizontal)
        }
        .frame(width: 250, height: 55)
    }
}

struct BuyButton_Previews: PreviewProvider {
    static var previews: some View {
        BuyButton(animate: .constant(true), itemType: .regeneration, price: 1000)
    }
}
