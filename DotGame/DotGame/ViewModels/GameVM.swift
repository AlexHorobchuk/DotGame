//
//  GameVM.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/30/23.
//

import Foundation

final class GameVM: ObservableObject {
    
    @Published var map: [[Station]]
    
    weak var logic: MoverService?
    
    var participators: [Participator]
    
    init (map: [[Station]], participators: [Participator]) {
        self.map = map
        self.participators = participators
    }
    
    func getColors() {
        var dictionary = [Participator? : Int]
        for i in map.flatMap({ $0 }) {
            
        }
    }
}
