//
//  Rope.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/2/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import Foundation
import SpriteKit


class Rope: SKSpriteNode {
    
    var startPoint: CGPoint
    var segments: [SKSpriteNode]
    
    init(withStartPoint startPoint: CGPoint, endPoint: CGPoint, numberOfSegments: Int, forScene scene: SKScene) {
        self.startPoint = startPoint
        self.segments = []
        super.init(texture: nil, color: .clear, size: scene.frame.size)
        
        for _ in 0..<numberOfSegments {
            let newSegment = SKSpriteNode.ropeSegment
            position(newSegment)
            scene.addChild(newSegment)
            applyPhysics(for: newSegment, in: scene)
            segments.append(newSegment)
        }
        segments.last?.position = endPoint
        segments.last?.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func position(_ segment: SKSpriteNode) {
        if let lastSegment = segments.last {
            segment.position = CGPoint(x: lastSegment.position.x  + lastSegment.size.width / 2, y: lastSegment.position.y)
        } else {
            segment.position = startPoint
        }
    }
    
    func applyPhysics(for segment: SKSpriteNode, in scene: SKScene) {
        
        if let lastSegment = segments.last {
            let limit = SKPhysicsJointLimit.joint(withBodyA: segment.physicsBody!, bodyB: lastSegment.physicsBody!, anchorA: segment.position, anchorB: lastSegment.position)
            limit.maxLength = segment.size.width
            scene.physicsWorld.add(limit)
        } else {
            segment.physicsBody?.isDynamic = false
        }
    }
}


extension SKSpriteNode {
    static var ropeSegment: SKSpriteNode {
        let segment = SKSpriteNode.init(imageNamed: "circle")
        segment.size = CGSize(width: 30, height: 30)
        segment.anchorPoint = .normalizedMiddle
        segment.physicsBody = SKPhysicsBody.init(circleOfRadius: segment.size.width / 2)
        segment.physicsBody?.angularDamping = 1
//        segment.physicsBody?.linearDamping = 1
        
        segment.physicsBody?.categoryBitMask = 1
        segment.physicsBody?.collisionBitMask = 1
        return segment
    }
}
