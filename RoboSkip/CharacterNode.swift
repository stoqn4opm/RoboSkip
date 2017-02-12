//
//  Character.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class CharacterNode: SKNode {
    fileprivate var bendLimit: SKPhysicsJointLimit?
    fileprivate let positionSwitchTime = 0.1
    fileprivate let springStrength: CGFloat = 34
}

//MARK: - Physics
extension CharacterNode {
    
    func setupPhysics() {
        attachHeadToBody()
        attachFeetToBody()
    }
    
    fileprivate func attachFeetToBody() {
        
        guard let body = self.childNode(withName: "body") as? SKSpriteNode else { return }
        guard let leg = self.childNode(withName: "leg") as? SKSpriteNode else { return }
        
        let spring = SKPhysicsJointSpring.joint(withBodyA: body.physicsBody!,
                                                bodyB: leg.physicsBody!,
                                                anchorA: body.position,
                                                anchorB: leg.position)
        spring.frequency = springStrength
        let slideLimit = SKPhysicsJointSliding.joint(withBodyA: body.physicsBody!,
                                                     bodyB: leg.physicsBody!,
                                                     anchor: body.position,
                                                     axis: CGVector(dx: 0, dy: 1))
        self.scene?.physicsWorld.add(spring)
        self.scene?.physicsWorld.add(slideLimit)
    }
    
    fileprivate func attachHeadToBody() {
        guard let body = self.childNode(withName: "body") as? SKSpriteNode else { return }
        guard let head = self.childNode(withName: "head") as? SKSpriteNode else { return }
        
        let spring = SKPhysicsJointSpring.joint(withBodyA: body.physicsBody!, bodyB: head.physicsBody!, anchorA: body.position, anchorB: head.position)
        spring.frequency = 8
        let slideLimit = SKPhysicsJointSliding.joint(withBodyA: body.physicsBody!, bodyB: head.physicsBody!, anchor: body.position, axis: CGVector(dx: 0, dy: 1))
        
        self.scene?.physicsWorld.add(spring)
        self.scene?.physicsWorld.add(slideLimit)
    }
}

//MARK: - Actions
extension CharacterNode {
    func bend() {
        guard let body = self.childNode(withName: "body") as? SKSpriteNode else { return }
        guard let leg = self.childNode(withName: "leg") as? SKSpriteNode else { return }
        
        bendLimit = SKPhysicsJointLimit.joint(withBodyA: body.physicsBody!,
                                              bodyB: leg.physicsBody!,
                                              anchorA: body.position,
                                              anchorB: leg.position)
        
        bendLimit!.maxLength = leg.size.height * 1.5
        self.scene?.physicsWorld.add(bendLimit!)
    }
    
    func jump() {
        guard let jumpLimit = bendLimit else { return }
        self.scene?.physicsWorld.remove(jumpLimit)
    }
    
    var scenePlacements: [CGFloat] {
        guard let width = self.scene?.size.width else { return [] }
        return [-width / 3, 0, width / 3]
    }
    
    func moveLeft() {
        if let currentIndex = scenePlacements.index(of: self.position.x) {
            guard currentIndex > 0 else { return }
            let newIndex = scenePlacements.index(before: currentIndex)
            let move = SKAction.moveTo(x: scenePlacements[newIndex], duration: positionSwitchTime)
            move.timingMode = .easeOut
            self.run(move)
        }
    }
    
    func moveRight() {
        if let currentIndex = scenePlacements.index(of: self.position.x) {
            guard currentIndex < scenePlacements.count - 1 else { return }
            let newIndex = scenePlacements.index(after: currentIndex)
            let move = SKAction.moveTo(x: scenePlacements[newIndex], duration: positionSwitchTime)
            move.timingMode = .easeOut
            self.run(move)
        }
    }
}
