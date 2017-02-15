//
//  Obstacles.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/13/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import SpriteKit

class Obstacles: SKNode {

}

//MARK: - Horizontal Lasers
extension Obstacles {

    func fireHorizontalLaser1() {
        self.fireLaser(withName: "BlasterHor1")
    }

    func fireHorizontalLaser2() {
        self.fireLaser(withName: "BlasterHor2")
    }
    
    func fireHorizontalLaser3() {
        self.fireLaser(withName: "BlasterHor3")
    }
    
    func fireHorizontalLaser4() {
        self.fireLaser(withName: "BlasterHor4")
    }
}

//MARK: - Vertical Lasers
extension Obstacles {
    
    func fireVerticalLaser1() {
        self.fireLaser(withName: "BlasterVer1")
    }
    
    func fireVerticalLaser2() {
        self.fireLaser(withName: "BlasterVer2")
    }
}

//MARK: - Helpers Functon
extension Obstacles {
    func fireLaser(withName name: String) {
        let blasterRef = self.childNode(withName: name) as? SKReferenceNode
        let blaster = blasterRef?.getBasedChildNode() as? Blaster
        blaster?.fire()
    }
}
