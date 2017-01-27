//
//  GameScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/26/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        let tile = SKSpriteNode.generateRepeatTiledImageNode(withTile: "sonic", size: UIScreen.main.bounds.size)
        tile?.anchorPoint = CGPoint.init(x: 0.0, y: 0.0)
        tile?.position = .zero
//        tile?.zPosition = 0
        tile?.size = CGSize(width: 1, height: 1)
        self.addChild(tile!)
    }
}
