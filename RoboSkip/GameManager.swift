//
//  GameManager.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/27/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    //MARK: Shared Instance
    static let shared : GameManager = {
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.ignoresSiblingOrder = true
        
        // various debug options
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        skView.showsFields = true
        skView.showsPhysics = true
        
        let instance = GameManager(skView: skView)
        return instance
    }()
    
    //MARK: Local Variable
    var skView : SKView
    
    //MARK: Init
    init(skView : SKView) {
        self.skView = skView
    }
}

//MARK: - Loading Scenes
extension GameManager {
    
    func loadMenuScene() {
        let scene = MenuScene(size: skView.frame.size)
        loadScene(scene: scene)
    }
    
    func loadLevelScene() {
        guard let scene = SKScene(fileNamed: "LevelScene") as? LevelScene else { return }
        loadScene(scene: scene)
    }
    
    private func loadScene(scene: SKScene) {
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}

