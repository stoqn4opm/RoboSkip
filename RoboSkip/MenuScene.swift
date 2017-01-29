//
//  GameScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/26/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        prepareBackground()
        let titleNode = SKSpriteNode(imageNamed: "title")
        titleNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        titleNode.position = CGPoint(x: self.frame.midX, y: self.frame.height * 0.25)
        self.addChild(titleNode)
    }
}

//MARK: - Prepare Background
extension MenuScene {
    
    func prepareBackground() {
        
        let screenWidth = self.frame.size.width
        let screenHeight = self.frame.size.height

        // setting outer bounds for moving tiled background
        let outherBackgroundBounds = CGRect(x: -2.5 * screenWidth, y: -2.5 * screenHeight,
                                            width: 5 * screenWidth, height: 5 * screenHeight)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: outherBackgroundBounds)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // tiled backround node
        let tiledBackgroundSize = CGSize.init(width: 3 * screenWidth, height: 3 * screenHeight)
        guard let tiledBackgroundNode = SKSpriteNode.generateRepeatTiledNodeWithTile(
            tile: "robothead", backgroundSizePoints: tiledBackgroundSize) else { return }
        
        tiledBackgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        tiledBackgroundNode.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        tiledBackgroundNode.physicsBody = SKPhysicsBody(rectangleOf: tiledBackgroundNode.frame.size)
        self.addChild(tiledBackgroundNode)
        
        // fade in animation
        let maskNode = SKShapeNode(rect: tiledBackgroundNode.frame)
        maskNode.fillColor = .black
        self.addChild(maskNode)
        let fadeInOfTilesAction = SKAction.sequence([SKAction.fadeOut(withDuration: 2), SKAction.run {
            maskNode.removeFromParent()
            }])
        maskNode.run(fadeInOfTilesAction)
        
        // setting up noise field
        physicsWorld.gravity = CGVector(dx:0, dy: 0)
        let gravityNode = SKFieldNode.noiseField(withSmoothness: 1, animationSpeed: 1)
        gravityNode.strength = 10
        addChild(gravityNode)
    }
}

extension CGSize {
    func sizeWithScale(_ scale: CGFloat) -> CGSize {
        return CGSize(width: width * scale, height: height * scale)
    }
}
