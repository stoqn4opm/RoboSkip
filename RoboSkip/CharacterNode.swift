//
//  MainCharacter.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/31/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class CharacterNode: SKSpriteNode {
    
    //MARK: - Static Properties
    static let bodySize = CGSize(width: 120, height: 100)
    static let headSize = CGSize(width: 80, height: 50)
    static let neckSize = CGSize(width: 50, height: 30)
    static let upperFootSize = CGSize(width: 50, height: 30)
    static let lowerFootSize = CGSize(width: 60, height: 35)
    
    //MARK: - Internal Properties
    fileprivate var body: SKSpriteNode!
    fileprivate var head: SKSpriteNode!
    fileprivate var neck: SKSpriteNode!
    fileprivate var topLeg: SKSpriteNode!
    fileprivate var bottomLeg: SKSpriteNode!
    fileprivate var feetSpring: SKPhysicsJointSpring?
    
    //MARK: - Public Properties
    var distanceBetweenTopAndBottomLeg: CGFloat = 80.0
    var shouldRestrictJumpsToVerticalOnly  = true
    
    //MARK: - Initializers
    init(forScene scene: SKScene) {
        super.init(texture: nil, color: .clear, size: scene.frame.size)
        setupBodyParts(forRect: scene.frame)
        scene.addChild(body)
        scene.addChild(head)
        scene.addChild(neck)
        scene.addChild(topLeg)
        scene.addChild(bottomLeg)
        setupPhysics(forScene: scene)
    }
    
    //MARK: Do not use
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Appearance
extension CharacterNode {
   fileprivate func setupBodyParts(forRect rect: CGRect) {
        
        // main body
        self.body = SKSpriteNode(color: .red, size: CharacterNode.bodySize)
        body.anchorPoint = .normalizedMiddle
        body.position = CGPoint(x: rect.midX, y: rect.midY)

        // head
        self.head = SKSpriteNode(color: .blue, size: CharacterNode.headSize)
        head.anchorPoint = .normalizedMiddle
        head.position = CGPoint(x: body.position.x, y: body.position.y + body.size.height)
        
        // neck
        self.neck =  SKSpriteNode(color: .green, size: CharacterNode.neckSize)
        neck.anchorPoint = .normalizedMiddle
        neck.position = CGPoint(x: body.position.x, y: body.position.y + body.size.height / 2 - neck.size.height / 2)
        
        // feet
        self.topLeg =  SKSpriteNode(color: .green, size: CharacterNode.upperFootSize)
        topLeg.anchorPoint = .normalizedMiddle
        topLeg.position = CGPoint(x: body.position.x, y: body.position.y - body.size.height / 2 - topLeg.size.height / 2)
        
        self.bottomLeg =  SKSpriteNode(color: .green, size: CharacterNode.lowerFootSize)
        bottomLeg.anchorPoint = .normalizedMiddle
        bottomLeg.position = CGPoint(x: body.position.x, y: topLeg.position.y - distanceBetweenTopAndBottomLeg)
    }
}

//MARK: - Physics
extension CharacterNode {
    
    fileprivate func setupPhysics(forScene scene: SKScene) {
        body.physicsBody = SKPhysicsBody(rectangleOf: body.frame.size)
        head.physicsBody = SKPhysicsBody(rectangleOf: head.frame.size)
        neck.physicsBody = SKPhysicsBody(rectangleOf: neck.frame.size)
        topLeg.physicsBody =  SKPhysicsBody(rectangleOf: topLeg.frame.size)
        bottomLeg.physicsBody =  SKPhysicsBody(rectangleOf: bottomLeg.frame.size)

        attachHeadToBody(forScene: scene)
        attachFeetToBody(forScene: scene)
    }
    
    fileprivate func attachFeetToBody(forScene scene: SKScene) {
        
        let pinAnchorPoint = CGPoint(x: body.position.x, y: body.position.y - body.size.height / 2)
        
        let pin = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!,
                                          bodyB: topLeg.physicsBody!,
                                          anchor: pinAnchorPoint)
        pin.shouldEnableLimits = true
        
        let spring = SKPhysicsJointSpring.joint(withBodyA: topLeg.physicsBody!,
                                                bodyB: bottomLeg.physicsBody!,
                                                anchorA: topLeg.position, anchorB: bottomLeg.position)
        spring.frequency = 8
        self.feetSpring = spring
        
        let sliding = SKPhysicsJointSliding.joint(withBodyA: topLeg.physicsBody!,
                                                  bodyB: bottomLeg.physicsBody!,
                                                  anchor: pinAnchorPoint, axis: CGVector.init(dx: 0, dy: 1))
        
        scene.physicsWorld.add(pin)
        scene.physicsWorld.add(spring)
        scene.physicsWorld.add(sliding)
        
        if shouldRestrictJumpsToVerticalOnly {
            guard let ground = scene.childNode(withName: "ground") else { return }
            
            let sliding1 = SKPhysicsJointSliding.joint(withBodyA: body.physicsBody!,
                                                      bodyB: ground.physicsBody!,
                                                      anchor: body.position, axis: CGVector.init(dx: 0, dy: 1))
            scene.physicsWorld.add(sliding1)
        }
    }
    
    fileprivate func attachHeadToBody(forScene scene: SKScene) {
        
        let pin = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!,
                                          bodyB: neck.physicsBody!,
                                          anchor: neck.position)
        pin.shouldEnableLimits = true
        scene.physicsWorld.add(pin)
        
        let spring = SKPhysicsJointSpring.joint(withBodyA: head.physicsBody!,
                                                bodyB: neck.physicsBody!,
                                                anchorA: head.position, anchorB: neck.position)
        spring.frequency = 8
        scene.physicsWorld.add(spring)
        
        let sliding1 = SKPhysicsJointSliding.joint(withBodyA: head.physicsBody!,
                                                   bodyB: neck.physicsBody!,
                                                   anchor: head.position, axis: CGVector.init(dx: 0, dy: 1))
        scene.physicsWorld.add(sliding1)
    }
}

//MARK: - Action
extension CharacterNode {
    func bendSpring() {
        self.feetSpring?.frequency = 1
    }
    
    func extendSpring() {
        self.feetSpring?.frequency = 8
    }
}
