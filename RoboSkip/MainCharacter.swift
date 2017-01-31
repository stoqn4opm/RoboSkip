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
    
    static let bodySize = CGSize(width: 120, height: 100)
    static let headSize = CGSize(width: 80, height: 50)
    static let footSize = CGSize(width: 50, height: 20)
    static let upperArmSize = CGSize(width: 20, height: 50)
    static let lowerArmSize = CGSize(width: 20, height: 20)
    
    
    var body: SKSpriteNode!
    var head: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    var upperLeftArm: SKSpriteNode!
    var upperRightArm: SKSpriteNode!
    var lowerLeftArm: SKSpriteNode!
    var lowerRightArm: SKSpriteNode!
    
    var leftFeetSprings: [SKPhysicsJointSpring]?
    var rightFeetSprings: [SKPhysicsJointSpring]?
    
    init(forScene scene: SKScene) {
        super.init(texture: nil, color: .clear, size: scene.frame.size)
        setupBodyParts(forRect: scene.frame)
//        setupPhysics(forScene: scene)
        scene.addChild(body)
        scene.addChild(head)
        scene.addChild(leftLeg)
        scene.addChild(rightLeg)
//        self.addChild(upperLeftArm)
//        self.addChild(upperRightArm)
//        self.addChild(lowerLeftArm)
//        self.addChild(lowerRightArm)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBodyParts(forRect rect: CGRect) {
        
        // main body
        self.body = SKSpriteNode(color: .red, size: CharacterNode.bodySize)
        body.anchorPoint = .normalizedMiddle
        body.position = CGPoint(x: rect.midX, y: rect.midY)

        // head
        self.head = SKSpriteNode(color: .blue, size: CharacterNode.headSize)
        head.anchorPoint = .normalizedMiddle
        head.position = CGPoint(x: body.position.x, y: body.position.y + body.size.height)
        
        // feet
        let yCoordFeet = body.position.y - 2 * body.size.height
        
        self.leftLeg =  SKSpriteNode(color: .green, size: CharacterNode.footSize)
        leftLeg.anchorPoint = .normalizedMiddle
        leftLeg.position = CGPoint(x: body.position.x - body.size.width / 2, y: yCoordFeet)
        
        self.rightLeg =  SKSpriteNode(color: .green, size: CharacterNode.footSize)
        rightLeg.anchorPoint = .normalizedMiddle
        rightLeg.position = CGPoint(x: body.position.x + body.size.width / 2, y: yCoordFeet)
    }
    
    func setupPhysics(forScene scene: SKScene) {
        body.physicsBody = SKPhysicsBody(rectangleOf: body.frame.size)
        head.physicsBody = SKPhysicsBody(rectangleOf: head.frame.size)
        leftLeg.physicsBody =  SKPhysicsBody(rectangleOf: leftLeg.frame.size)
        rightLeg.physicsBody =  SKPhysicsBody(rectangleOf: rightLeg.frame.size)
        
        // head body attachment
        attachHeadToBody(forScene: scene)
        attachFeetToBody(forScene: scene)
    }
    
    func attachFeetToBody(forScene scene: SKScene) {
        
        let yCoordBodyAnchors = body.position.y
        let leftBodyAnchor = CGPoint(x: body.position.x - body.size.width / 2, y: yCoordBodyAnchors)
        let rightBodyAnchor = CGPoint(x: body.position.x + body.size.width / 2, y: yCoordBodyAnchors)
        let midBodyAnchor = CGPoint(x: body.position.x, y: body.position.y - body.size.height / 2)
        
        let leftSpring = SKPhysicsJointSpring.joint(withBodyA: leftLeg.physicsBody!, bodyB: body.physicsBody!, anchorA: leftLeg.position, anchorB: leftBodyAnchor)
        
        let rightSpring = SKPhysicsJointSpring.joint(withBodyA: rightLeg.physicsBody!, bodyB: body.physicsBody!, anchorA: rightLeg.position, anchorB: rightBodyAnchor)
        
        let feetJoint = SKPhysicsJointSpring.joint(withBodyA: leftLeg.physicsBody!, bodyB: rightLeg.physicsBody!, anchorA: leftLeg.position, anchorB: rightLeg.position)
        
        let midLeftSpring = SKPhysicsJointSpring.joint(withBodyA: leftLeg.physicsBody!, bodyB: body.physicsBody!, anchorA: leftLeg.position, anchorB: midBodyAnchor)
        
        let midRightSpring = SKPhysicsJointSpring.joint(withBodyA: rightLeg.physicsBody!, bodyB: body.physicsBody!, anchorA: rightLeg.position, anchorB: midBodyAnchor)
        
        leftSpring.frequency = 5
        rightSpring.frequency = 5
        midLeftSpring.frequency = 5
        midRightSpring.frequency = 5
        feetJoint.frequency = 0
        
        scene.physicsWorld.add(leftSpring)
        scene.physicsWorld.add(rightSpring)
        scene.physicsWorld.add(midLeftSpring)
        scene.physicsWorld.add(midRightSpring)
        scene.physicsWorld.add(feetJoint)
        
        self.leftFeetSprings = [leftSpring, midLeftSpring]
        self.rightFeetSprings = [rightSpring, midRightSpring]
    }
    
    func attachHeadToBody(forScene scene: SKScene) {
        let yCoordHeadAnchors = head.position.y - head.size.height / 2
        let leftHeadAnchor = CGPoint(x: head.position.x - head.size.width / 4, y: yCoordHeadAnchors)
        let rightHeadAnchor = CGPoint(x: head.position.x + head.size.width / 4, y: yCoordHeadAnchors)
        
        let yCoordBodyAnchors = body.position.y + body.size.height / 2
        let leftBodyAnchor = CGPoint(x: body.position.x - body.size.width / 4, y: yCoordBodyAnchors)
        let rightBodyAnchor = CGPoint(x: body.position.x + body.size.width / 4, y: yCoordBodyAnchors)
        
        let leftSpring = SKPhysicsJointSpring.joint(withBodyA: head.physicsBody!, bodyB: body.physicsBody!, anchorA: leftHeadAnchor, anchorB: leftBodyAnchor)
        
        let rightSpring = SKPhysicsJointSpring.joint(withBodyA: head.physicsBody!, bodyB: body.physicsBody!, anchorA: rightHeadAnchor, anchorB: rightBodyAnchor)
        
        let crossSpring1 = SKPhysicsJointSpring.joint(withBodyA: head.physicsBody!, bodyB: body.physicsBody!, anchorA: rightHeadAnchor, anchorB: leftBodyAnchor)
        
        let crossSpring2 = SKPhysicsJointSpring.joint(withBodyA: head.physicsBody!, bodyB: body.physicsBody!, anchorA: leftHeadAnchor, anchorB: rightBodyAnchor)
        
        leftSpring.frequency = 6
        rightSpring.frequency = 6
        crossSpring1.frequency = 6
        crossSpring2.frequency = 6
        
        scene.physicsWorld.add(leftSpring)
        scene.physicsWorld.add(rightSpring)
        scene.physicsWorld.add(crossSpring1)
        scene.physicsWorld.add(crossSpring2)
    }
}

//extension CGSize {
//    var halfWidth: CGFloat {
//        return self.width / 2
//    }
//    var halfHeight: CGFloat {
//        return self.height / 2
//    }
//}

extension CGPoint {
    static var normalizedMiddle: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
    
    static var normalizedUpperLeft: CGPoint {
        return CGPoint(x: 0, y: 1)
    }
    
    static var normalizedUpperRight: CGPoint {
        return CGPoint(x: 1, y: 1)
    }
}
