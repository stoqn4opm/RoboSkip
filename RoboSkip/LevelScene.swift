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

        let groundSize = CGSize(width: self.frame.width, height: self.frame.height * 0.2)
        let groundNode = SKSpriteNode(color: .gray, size: groundSize)
        groundNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(groundNode)
        groundNode.position = CGPoint(x: 0, y: 0)
    }
}
