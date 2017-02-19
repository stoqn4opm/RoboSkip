//
//  GameManager.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/27/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import Foundation
import SpriteKit
import SwiftyJSON

class GameManager: Loggable {
    static let shouldLogInConsole = true
    
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
        
        guard let json = loadLevelInfo() else {
            printLog("no level info")
            return
        }
        scene.sceneInfo = json
        loadScene(scene: scene)
    }
    
    private func loadScene(scene: SKScene) {
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}

extension GameManager {
    func loadLevelInfo() -> JSON? {
        guard let filePath = Bundle.main.path(forResource: "test_level", ofType: "json") else {
            printLog("test_level.json not found")
            return nil
        }
        guard let jsonString = try? String.init(contentsOfFile: filePath, encoding: .utf8) else {
            printLog("can not load test_level.json file")
            return nil
        }
        guard let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        let json = JSON(data: dataFromString)
        return json
    }
}
