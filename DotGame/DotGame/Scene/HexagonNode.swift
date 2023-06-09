//
//  StationNode.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/8/23.
//

import SpriteKit

class HexagonNode: SKShapeNode {
    
    var station: Station
    
    init(station: Station) {
        self.station = station
        let hexagonPath = Hexagon(radius: 10).path(in: CGRect(x: 0, y: 0, width: 73, height: 72))
        super.init()
        
        self.path = hexagonPath.cgPath
        self.fillColor = .clear
        self.strokeColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
