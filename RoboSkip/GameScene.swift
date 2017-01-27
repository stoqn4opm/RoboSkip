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
        let tile = SKSpriteNode.generateRepeatTiledNodeWithTile(tile: "sonic", tileSize: CGSize(width: 1, height: 1), coverageSize: CGSize(width: 367, height: 600))
        
//        tile.size = CGSize(width: 1, height: 1)
        let move = SKAction.move(to: CGPoint(x: 100, y: 100), duration: 200)
        tile.run(move)
        self.addChild(tile)
    }
}
