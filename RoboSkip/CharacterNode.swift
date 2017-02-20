//
//  Character.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class CharacterNode: SKNode {

}

//MARK: - Actions
extension CharacterNode {
    func land() {
        guard let body = self.childNode(withName: "body") as? SKSpriteNode else { return }
        body.removeAllActions()
        let scaleUp = SKAction.scale(by: -0.2, duration: 2)
        body.run(scaleUp)
    }
    
    func jump() {
        guard let body = self.childNode(withName: "body") as? SKSpriteNode else { return }
        body.removeAllActions()
        let scaleUp = SKAction.scale(by: 0.2, duration: 2)
        body.run(scaleUp)
    }
}
