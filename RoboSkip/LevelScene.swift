//
//  LevelScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit
import SwiftyJSON

class LevelScene: SKScene {

    //MARK: - Properties
    var sceneInfo: JSON?
    
    var character: CharacterNode!
    var radiaGravity: SKFieldNode?
    
    //MARK: - Entrance Point Of Scene
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        self.radiaGravity = childNode(withName: "radialGravity") as? SKFieldNode
        loadObstacles()
    }

    
    //MARK: - Dismiss Point Of Scene
    override func willMove(from view: SKView) {
        super.willMove(from: view)
    }
}

//MARK: - Obstacles
extension LevelScene: Loggable {
    func loadObstacles() {
        let obstaclesLayerRef = self.childNode(withName: "Obstacles") as? SKReferenceNode
        guard let obstaclesLayer = obstaclesLayerRef?.getBasedChildNode() as? Obstacles else {
            printLog("no obstacles layer")
            return
        }
        let obstaclesController = JSONObstaclesController(obstacles: obstaclesLayer)
        if let blastersPattern = sceneInfo?["blasters"].array {
            obstaclesController.playBlastersPattern(from: blastersPattern)
        }
    }
}

//MARK: - User Touches
extension LevelScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        radiaGravity?.isEnabled = true
        radiaGravity?.position = touches.first!.location(in: self)
        markTouch(at: touches.first!.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        radiaGravity?.position = touches.first!.location(in: self)
        let mark = childNode(withName: "touchMarker")
        mark?.position = touches.first!.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        radiaGravity?.isEnabled = false
        removeMark()
    }
    
    func markTouch(at point: CGPoint) {
        let mark = SKSpriteNode(imageNamed: "fieldChange")
        mark.name = "touchMarker"
        mark.alpha = 0
        mark.zPosition = -1
        mark.anchorPoint = .normalizedMiddle
        mark.position = point
        mark.setScale(0.1)
        self.addChild(mark)
        mark.run(markAction)
    }
    
    func removeMark() {
        for child in children {
            if child.name == "touchMarker" {
                child.removeAllActions()
                child.run(unMarkAction)
            }
        }
    }
    
    var markAction: SKAction {
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        let scaleIn = SKAction.scale(to: 0.8, duration: 0.4)
        return SKAction.group([fadeIn, scaleIn])
    }
    
    var unMarkAction: SKAction {
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let scaleDown = SKAction.scale(to: 0.1, duration: 0.1)
        SKAction.removeFromParent()
        let group = SKAction.group([fadeOut, scaleDown])
        group.timingMode = .easeIn
        return SKAction.sequence([group, SKAction.removeFromParent()])
    }
}
