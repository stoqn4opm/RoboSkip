//
//  HelperExtensions.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/1/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import SpriteKit


extension SKReferenceNode {
    func getBasedChildNode () -> SKNode? {
        if let child = self.children.first?.children.first {return child}
        else {return nil}
    }
}

extension CGPoint {
    static var normalizedMiddle: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
    
    static var normalizedUpperLeft: CGPoint {
        return CGPoint(x: 0, y: 1)
    }
    
    static var normalizedUpperRight: CGPoint {
        return CGPoint(x: 1, y: 1)
    }
    
    static var normalizedUpperCenter: CGPoint {
        return CGPoint(x: 0.5, y: 1)
    }
    
    static var normalizedLowerCenter: CGPoint {
        return CGPoint(x: 0.5, y: 0)
    }
    
    static var normalizedLowerLeft: CGPoint {
        return CGPoint(x: 0, y: 0)
    }
}
