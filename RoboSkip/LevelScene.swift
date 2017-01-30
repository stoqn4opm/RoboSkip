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
    
    override func didMove(to view: SKView) {

        setupGround()
        
        let body = SKSpriteNode(color: .red, size: CGSize(width: 150, height: 150))
        body.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        body.position = CGPoint(x: self.frame.midX, y: 200 + self.frame.midY)
        self.addChild(body)
        
        body.physicsBody = SKPhysicsBody(rectangleOf: body.frame.size)
        
        let arm =  SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        arm.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        arm.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(arm)
        
        arm.physicsBody =  SKPhysicsBody(rectangleOf: arm.frame.size)
        
        let springJoint = SKPhysicsJointSpring.joint(withBodyA: body.physicsBody!, bodyB: arm.physicsBody!, anchorA: .zero, anchorB: CGPoint(x: 20, y: 30))
     self.physicsWorld.add(springJoint)
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
