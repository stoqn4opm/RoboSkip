//
//  Blaster.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/13/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import SpriteKit

fileprivate let flashSpeed1 = SKAction.wait(forDuration: 0.5)
fileprivate let flashSpeed2 = SKAction.wait(forDuration: 0.2)
fileprivate let flashSpeed3 = SKAction.wait(forDuration: 0.1)

fileprivate let flashSpeed1RepeatCount = 1
fileprivate let flashSpeed2RepeatCount = 2
fileprivate let flashSpeed3RepeatCount = 5

class Blaster: SKNode {

    fileprivate var firstBlaster: SKSpriteNode? {
        return self.childNode(withName: "first") as? SKSpriteNode
    }
    fileprivate var secondBlaster: SKSpriteNode? {
        return self.childNode(withName: "second") as? SKSpriteNode
    }
    fileprivate var beam: SKSpriteNode? {
        return self.childNode(withName: "beam") as? SKSpriteNode
    }
}

//MARK: - Actions
extension Blaster {
    func fireAction() -> SKAction {
        
        let flashBlasters = SKAction.sequence([flashAtSpeed1Action,
                                               flashAtSpeed2Action,
                                               flashAtSpeed3Action,
                                               turnOnBeamFor(2)])
        return flashBlasters
    }
}

//MARK: - Beam
extension Blaster {
    
    fileprivate func turnOnBeamFor(_ time: TimeInterval) -> SKAction {
        
        let wait = SKAction.wait(forDuration: time)

        guard let beam = self.beam else { return wait }
        let beamOn = SKAction.run {
            beam.alpha = 1
            beam.physicsBody = SKPhysicsBody(rectangleOf: beam.size)
            beam.physicsBody?.affectedByGravity = false
            beam.physicsBody?.allowsRotation = false
            beam.physicsBody?.isDynamic = false
        }
        let beamOff = SKAction.run {
            beam.alpha = 0
            beam.physicsBody = nil
        }
        return SKAction.sequence([beamOn, wait, beamOff])
    }
}

//MARK: - Blasters Alpha Actions
extension Blaster {
    
    fileprivate var flashAtSpeed1Action: SKAction {
        return SKAction.repeat(blinkAtSpeed1Action, count: flashSpeed1RepeatCount)
    }
    
    fileprivate var flashAtSpeed2Action: SKAction {
        return SKAction.repeat(blinkAtSpeed2Action, count: flashSpeed2RepeatCount)
    }
    
    fileprivate var flashAtSpeed3Action: SKAction {
        return SKAction.repeat(blinkAtSpeed3Action, count: flashSpeed3RepeatCount)
    }
    
    //MARK: Building Blocks
    private var blinkAtSpeed1Action: SKAction { return blink(withDelay: flashSpeed1) }
    private var blinkAtSpeed2Action: SKAction { return blink(withDelay: flashSpeed2) }
    private var blinkAtSpeed3Action: SKAction { return blink(withDelay: flashSpeed3) }
    
    private func blink(withDelay delay: SKAction) -> SKAction {
        return SKAction.sequence([blastersZeroAlphaAction, delay,
                                  blastersFullAlphaAction, delay])
    }
    
    private var blastersZeroAlphaAction: SKAction { return changeAlphaOfBlastersTo(0.0) }
    private var blastersFullAlphaAction: SKAction { return changeAlphaOfBlastersTo(1.0) }
    
    private func changeAlphaOfBlastersTo(_ value: CGFloat) -> SKAction {
        return SKAction.run({[weak self] (Void) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.firstBlaster?.alpha = value
            strongSelf.secondBlaster?.alpha = value
        })
    }
}
