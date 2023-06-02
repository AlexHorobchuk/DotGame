//
//  GameScene.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import SpriteKit

    
final class GameScene: SKScene {
    
    var viewModel: GameVM
    
    init(viewModel: GameVM, size: CGSize) {
        self.viewModel = viewModel
        super.init(size: size)
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = .clear
        viewModel.logic = self
    }
}
