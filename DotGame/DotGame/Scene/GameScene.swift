//
//  GameScene.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 5/29/23.
//

import SpriteKit

    
final class GameScene: SKScene {
    
    var viewModel: GameVM
    var stationCoordinates = [Coordinate : CGPoint]()
    
    init(viewModel: GameVM, size: CGSize) {
        self.viewModel = viewModel
        super.init(size: size)
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0, y: 1)
        backgroundColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = .clear
        viewModel.logic = self
        makeCoordinatefromMatrix()
        viewModel.setParticipators()
    }
    
    func createBall(at point: CGPoint, owner: ParticipatorType, radius: CGFloat = 6) -> SKShapeNode {
        let ballNode = SKShapeNode(circleOfRadius: radius)
        ballNode.fillColor = SKColor(owner.getParticipatorColor())
        ballNode.position = point
        self.addChild(ballNode)
        return ballNode
    }
    
    func getMatrixLargestRow() -> CGFloat {
        var largestRow = [Int]()
        for row in viewModel.matrix {
           if row.count > largestRow.count {
                largestRow = row
            }
        }
        return CGFloat(largestRow.count)
    }
    
    func getStartingPoint(matrixRow: [Int]) -> CGFloat {
        let spacing = 4
        let count = matrixRow.count
        let spacingAmount = count - 1
        let widthWithoutSpacing = self.frame.width - CGFloat(spacing * spacingAmount)
        let halphSize = widthWithoutSpacing / getMatrixLargestRow() / 2
        return halphSize + (halphSize * (getMatrixLargestRow() - CGFloat(count)))
    }
    
    func makeCoordinatefromMatrix() {
        let ySpacing = 57.0
        let xSpacing = 77.0
        var startingHeight = -36.5
        for (row, arr) in viewModel.matrix.enumerated() {
            var startingWidth = getStartingPoint(matrixRow: arr)
            for column in arr.indices {
                stationCoordinates[Coordinate(x: column, y: row)] = CGPoint(x: startingWidth, y: startingHeight)
                startingWidth += xSpacing
                
            }
            startingHeight -= ySpacing
        }
    }
        
    func sendBalls(index: Int, maxBalls: Int, from stationA: Station, to stationB: Station, by participator: Participator) {
        guard let coordinatsA = stationCoordinates[stationA.position],
           let coordinatsB = stationCoordinates[stationB.position]
            else { return }
        let ball = createBall(at: coordinatsA, owner: participator.type)
        let angle = atan2(coordinatsB.y - coordinatsA.y, coordinatsB.x - coordinatsA.x)
        let adjustmentAngle = angle + CGFloat(index - (maxBalls - 1) / 2) * 20.0 * .pi / 180.0
        let coordinatesX = coordinatsA.x + 30 * cos(adjustmentAngle)
        let coordinatesY = coordinatsA.y + 30 * sin(adjustmentAngle)
        let timeToStart = coordinatsA.distance(point: CGPoint(x: coordinatesX, y: coordinatesY)) / 80
        let timeToFinish = CGPoint(x: coordinatesX, y: coordinatesY).distance(point: coordinatsB) / 80
        
        
        let getToStart = SKAction.move(to: CGPoint(x: coordinatesX, y: coordinatesY), duration: timeToStart)
        let getToStation = SKAction.move(to: coordinatsB, duration: timeToFinish)
        let attackStation = SKAction.run { self.viewModel.stationAttacked(station: stationB, by: participator.type) }
        let removeBall = SKAction.run { ball.removeFromParent() }
        
        ball.run(.sequence([getToStart, getToStation, attackStation, removeBall]))
        
    }
}
