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
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
