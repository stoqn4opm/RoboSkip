//
//  LevelScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 2/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit
import SwiftyJSON

class LevelScene: SKScene {

    //MARK: - Properties
    var sceneInfo: JSON?
    
    var character: CharacterNode!
    var leftSwipeRecognizer: UIGestureRecognizer?
    var rightSwipeRecognizer: UIGestureRecognizer?
    var jumpHoldRecognizer: UIGestureRecognizer?
    var bendHeadHoldRecognizer: UIGestureRecognizer?
    
    //MARK: - Entrance Point Of Scene
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
        setupGestureRecognizers()
        loadCharacter()
        loadObstacles()
    }

    
    //MARK: - Dismiss Point Of Scene
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removeGestureRecognizers()
    }
}

//MARK: - Character
extension LevelScene {
    func loadCharacter() {
        let characterRef = self.childNode(withName: "Character") as? SKReferenceNode
        character = characterRef?.getBasedChildNode() as! CharacterNode
        character?.setupPhysics()
    }
}

//MARK: - Obstacles
extension LevelScene: Loggable {
    func loadObstacles() {
        let obstaclesLayerRef = self.childNode(withName: "Obstacles") as? SKReferenceNode
        guard let obstaclesLayer = obstaclesLayerRef?.getBasedChildNode() as? Obstacles else {
            printLog("no obstacles layer")
            return
        }
        let obstaclesController = JSONObstaclesController(obstacles: obstaclesLayer)
        if let blastersPattern = sceneInfo?["blasters"].array {
            obstaclesController.playBlastersPattern(from: blastersPattern)
        }
    }
}

//MARK: - Gesture Recognizers
extension LevelScene {
    
    func setupGestureRecognizers() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        left.direction = .left
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        right.direction = .right
        
        let jump = UILongPressGestureRecognizer(target: self, action: #selector(jumpHoldRecogizer(_:)))
        jump.minimumPressDuration = 0
        
        let bendHead = UILongPressGestureRecognizer(target: self, action: #selector(bendHeadHoldRecogizer(_:)))
        bendHead.minimumPressDuration = 1
        
        view?.addGestureRecognizer(left)
        view?.addGestureRecognizer(right)
        view?.addGestureRecognizer(jump)
        view?.addGestureRecognizer(bendHead)
        
        leftSwipeRecognizer = left
        rightSwipeRecognizer = right
        jumpHoldRecognizer = jump
        bendHeadHoldRecognizer = bendHead
        
        left.delegate = self
        right.delegate = self
        jump.delegate = self
    }
    
    func removeGestureRecognizers() {
        guard
            let left = leftSwipeRecognizer,
            let right = rightSwipeRecognizer,
            let tap = jumpHoldRecognizer,
            let head = bendHeadHoldRecognizer
            else { return }
        
        view?.removeGestureRecognizer(left)
        view?.removeGestureRecognizer(right)
        view?.removeGestureRecognizer(tap)
        view?.removeGestureRecognizer(head)
    }
    
    @objc func swipeLeft() { character.moveLeft() }
    @objc func swipeRight() { character.moveRight() }
    
    
    func jumpHoldRecogizer(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            character.bend()
        } else {
            if recognizer.state == .cancelled ||
                recognizer.state == .ended ||
                recognizer.state == .failed {
                character.jump()
            }
        }
    }
    
    func bendHeadHoldRecogizer(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            character.bendHead()
        } else {
            if recognizer.state == .cancelled ||
                recognizer.state == .ended ||
                recognizer.state == .failed {
                character.releaseHead()
            }
        }
    }
}

//MARK: - Gesture Recognizer Delegate Methods
extension LevelScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
