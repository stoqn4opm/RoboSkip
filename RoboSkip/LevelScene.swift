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
    var tapHoldRecognizer: UIGestureRecognizer?
    
    
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
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        radiaGravity?.position = touches.first!.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        radiaGravity?.isEnabled = false
    }
}

//MARK: - Gesture Recognizer Delegate Methods
extension LevelScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
