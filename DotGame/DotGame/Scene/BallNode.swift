//
//  BallNode.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/8/23.
//

import SpriteKit

class BallNode: SKShapeNode {
    
    var owner: ParticipatorType
    
    init(owner: ParticipatorType, radius: CGFloat) {
        self.owner = owner
        super.init()
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        setUpNode(radius: radius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpNode(radius: CGFloat) {
        self.fillColor = SKColor(owner.getParticipatorColor())
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.categoryBitMask = owner.getMyBitMask()
        self.physicsBody?.contactTestBitMask = owner.getEnemysBitsMask()
        self.physicsBody?.affectedByGravity = false
    }
}
