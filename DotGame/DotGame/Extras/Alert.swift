//
//  Alert.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/12/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertConfirmation {
    
    static let goBack = AlertItem(title: Text("Do you want to leave?"),
                                  message: Text("Game results will not be saved"),
                                  dismissButton: .default(Text("No")))
}
