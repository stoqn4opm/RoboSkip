//
//  ObstaclesController.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/16/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import Foundation

let level =

"<level>\r\nbH_1\r\nBV_2\r\n</level>"


class ObstaclesController {
    
    static let printTag = "[ObstaclesController] "
    
    let startOfLevelTag = "<level>"
    let endOfLevelTag = "</level>"
    
    func playPattern(pattern: String) {
        
        guard let lines = getLinesFrom(pattern) else { return }
     
        for line in lines {
            
        }
    }
    
    
    func getLinesFrom(_ pattern: String) -> [String]? {
        guard
            pattern.hasPrefix(startOfLevelTag),
            pattern.hasSuffix(endOfLevelTag) else {
                log("no start & end tags")
                return nil
        }
        
        var lines = pattern.components(separatedBy: "\r\n")
        guard lines.count > 2 else {
            log("no lines to be parsed")
            return nil
        }
        
        lines.removeFirst()
        lines.removeLast()
        
        return lines
    }
}

func log(_ string: String) {
    print(ObstaclesController.printTag + string)
}
