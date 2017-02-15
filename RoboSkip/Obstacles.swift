//
//  Obstacles.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/13/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import SpriteKit

class Obstacles: SKNode {

    func fireHorizontalLaser1() {
        let blasterRef = self.childNode(withName: "BlasterHor1") as? SKReferenceNode
        let blaster = blasterRef?.getBasedChildNode() as? Blaster
        blaster?.fire()
    }
    
    func fireVerticalLaser1() {
        let blasterRef = self.childNode(withName: "BlasterVer1") as? SKReferenceNode
        let blaster = blasterRef?.getBasedChildNode() as? Blaster
        blaster?.fire()
    }
}
