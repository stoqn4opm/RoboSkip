//
//  Obstacles.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/13/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import SpriteKit

class Obstacles: SKNode {

    enum BlasterNames: String {
        case hor1 = "BlasterHor1"
        case hor2 = "BlasterHor2"
        case hor3 = "BlasterHor3"
        case hor4 = "BlasterHor4"
        
        case ver1 = "BlasterVer1"
        case ver2 = "BlasterVer2"
    }
    
    func getBlasterRef(_ name: BlasterNames) -> SKReferenceNode? {
        let blasterRef = self.childNode(withName: name.rawValue) as? SKReferenceNode
        return blasterRef
    }
    
    func fireBlasterAction(for ref: SKReferenceNode?) -> SKAction? {
        return ref?.fireBlasterAction()
    }
}

extension SKReferenceNode {
    fileprivate func fireBlasterAction() -> SKAction? {
        guard let child = children.first else { return nil }
        child.name = "child"
        guard let action = child.blasterAction() else { return nil }
        return SKAction.run(action, onChildWithName: child.name!)
    }
}

extension SKNode {
    fileprivate func blasterAction() -> SKAction? {
        if let blasterChild = children.first as? Blaster {
            if blasterChild.name == nil {
                blasterChild.name = "blaster_child"
            }
            let action = SKAction.run(blasterChild.fireAction(), onChildWithName: blasterChild.name!)
            return action
        }
        return nil
    }
}
