//
//  LevelScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class LevelScene: SKScene {

    //MARK: - Properties
    var character: CharacterNode!
    var leftSwipeRecognizer: UIGestureRecognizer?
    var rightSwipeRecognizer: UIGestureRecognizer?
    var tapHoldRecognizer: UIGestureRecognizer?
    
    //MARK: - Entrance Point Of Scene
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
        setupGestureRecognizers()
        loadCharacter()
        
        let obstaclesLayerRef = self.childNode(withName: "Obstacles") as? SKReferenceNode
        let obstaclesLayer = obstaclesLayerRef?.getBasedChildNode() as? Obstacles
        obstaclesLayer?.fireVerticalLaser1()
    }

    
    //MARK: - Dismiss Point Of Scene
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeGestureRecognizers()
    }
}
