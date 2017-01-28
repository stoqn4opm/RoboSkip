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
        
        guard let tile = SKSpriteNode.generateRepeatTiledNodeWithTile(tile: "robothead", backgroundSizePoints: CGSize.init(width: 4000, height: 4000)) else { return }
        tile.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        
        let action = SKAction.moveBy(x: 300, y: 300, duration: 5)
        tile.run(action)
        self.addChild(tile)
        
    }
}

extension CGSize {
    func sizeWithScale(_ scale: CGFloat) -> CGSize {
        return CGSize(width: width * scale, height: height * scale)
    }
}
