//
//  GameScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/26/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        let tile = SKSpriteNode.generateRepeatTiledNodeWithTile(tile: "sonic", backgroundSizePoints: UIScreen.main.bounds.size)
        tile.anchorPoint = CGPoint.zero
        tile.position = .zero
//        tile?.zPosition = 0
        tile.size = CGSize(width: 1, height: 1)
        self.addChild(tile)
    }
}
