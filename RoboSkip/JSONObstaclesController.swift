//
//  JSONObstaclesController.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/17/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import Foundation
import SwiftyJSON
import SpriteKit

//MARK: - Initialization
class JSONObstaclesController: Loggable {
    
    let obstacles: Obstacles
    var actionsQueue: [SKAction] = []
    
    init(obstacles: Obstacles) {
        self.obstacles = obstacles
    }
}

//MARK: - Blasters Pattern
extension JSONObstaclesController {
    
    func playBlastersPattern(from json: [JSON]) {
        
        for command in json {
            let oldActionQueueCount = actionsQueue.count
            recursiveHelper(json: command, queue: &actionsQueue)
            guard oldActionQueueCount != actionsQueue.count else { continue }
            actionsQueue.append(SKAction.wait(forDuration: 1))
        }
        let wholeComplexAction = SKAction.sequence(actionsQueue)
        obstacles.run(wholeComplexAction)
    }
    
    private func recursiveHelper(json: JSON, queue: inout [SKAction]) {
        
        if let commandGroup = json.array {
            // append group of commands
            
            var commands: [SKAction] = []
            for command in commandGroup {
                recursiveHelper(json: command, queue: &commands)
            }
            guard commands.count > 0 else { return }
            let groupAction = SKAction.group(commands)
            queue.append(groupAction)
        }
        else if let singleCommand = json.string {
            // append single command
            guard let action = append(singleCommand) else { return }
            queue.append(action)
        }
    }
    
    private func append(_ command: String) -> SKAction? {
        guard let blasterName = Obstacles.BlasterNames(rawValue: command) else {
            printLog("not a blaster name")
            return nil
        }
        guard let blasterRef = obstacles.getBlasterRef(blasterName) else {
            printLog("not such blaser in scene")
            return nil
        }
        guard let fireBlasterAction = obstacles.fireBlasterAction(for: blasterRef) else {
            printLog("no blaster action")
            return nil
        }
        let action = SKAction.run(fireBlasterAction, onChildWithName: blasterName.rawValue)
        return action
    }
}