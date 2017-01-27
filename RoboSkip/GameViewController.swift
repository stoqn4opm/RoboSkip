//
//  GameViewController.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = GameManager.shared.skView
        GameManager.shared.loadMenuScene()
        //
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//            
//                // Present the scene
//                view.presentScene(scene)
//
//            
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
