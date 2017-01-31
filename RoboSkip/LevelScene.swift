//
//  LevelScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/29/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit


class LevelScene: SKScene {
    
    var leftSpring: SKPhysicsJointSpring?
    var rightSpring: SKPhysicsJointSpring?
    var character: CharacterNode!
    
    override func didMove(to view: SKView) {

        setupGround()
        character = CharacterNode(forScene: self)
        character.setupPhysics(forScene: self)
        self.addChild(character)
    }
}

extension LevelScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for spring in character.leftFeetSprings! {
            spring.frequency = 1
        }
        for spring in character.rightFeetSprings! {
            spring.frequency = 1
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for spring in character.leftFeetSprings! {
            spring.frequency = 5
        }
        for spring in character.rightFeetSprings! {
            spring.frequency = 5
        }
    }
}

extension LevelScene {
    
    func setupGround() {
        
        let groundSize = CGSize(width: self.frame.width, height: self.frame.height * 0.1)
        let groundNode = SKSpriteNode(color: .gray, size: groundSize)
        groundNode.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(groundNode)
        groundNode.position = CGPoint(x: 0, y: 0)
        groundNode.physicsBody = SKPhysicsBody(rectangleOf: groundNode.frame.size,
                                               center: CGPoint(x: groundNode.frame.midX, y: groundNode.frame.midY))
        groundNode.physicsBody?.isDynamic = false
        
        self.backgroundColor = .black
    }
}
