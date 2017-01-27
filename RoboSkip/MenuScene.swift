//
//  MenuScene.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/26/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
//        self.backgroundColor = UIColor(patternImage: UIImage(named: "sonic")!)
        
        let size = CGSize(width: 375, height: 667)
        let tileNode = generateRepeatTileImageNode(imageName: "sonic", backgroundSizePoints: size)
        tileNode.position = .zero
        tileNode.anchorPoint = .zero
        self.addChild(tileNode)
    }
}


extension MenuScene {
    
    func generateRepeatTileImageNode(imageName: String, backgroundSizePoints: CGSize) -> SKSpriteNode {
        let tileTexture = SKTexture.init(imageNamed: imageName)
        let tileSizePixels = CGSize(width: tileTexture.size().width, height: tileTexture.size().width)
        let screenScale = UIScreen.main.scale
        let coverageSizePixels = CGSize(width: backgroundSizePoints.width * screenScale, height: backgroundSizePoints.height * screenScale)
        let coverageSizePoints =  CGSize(width: coverageSizePixels.width / screenScale, height: coverageSizePixels.height / screenScale)
        
//        let mainBundleInfoDict = Bundle.main.infoDictionary
//        let preferesOpenGLNum = mainBundleInfoDict!["PrefersOpenGL"] as! NSNumber
        let preferesOpenGL = true // preferesOpenGLNum.boolValue
        
        
        // OpenGL shader : 60 FPS
        // Metal shader :  39 FPS
        
        let shaderFilename = preferesOpenGL ? "shader_opengl.fsh" : "shader_metal.fsh"
        let shader = SKShader(fileNamed: shaderFilename)
        
        let outSampleHalfPixelOffsetX = 1.0 / (2.0 * coverageSizePixels.width)
        let outSampleHalfPixelOffsetY = 1.0 / (2.0 * coverageSizePixels.height)
        
        shader.addUniform(SKUniform.init(name: "outSampleHalfPixelOffset", float: GLKVector2Make(Float(outSampleHalfPixelOffsetX), Float(outSampleHalfPixelOffsetY))))
        
        
        let tileWidth = tileSizePixels.width
        let tileHeight = tileSizePixels.height

        shader.addUniform(SKUniform.init(name: "tileSize", float: GLKVector2Make(Float(tileWidth), Float(tileHeight))))
        
        let inSampleHalfPixelOffsetX = 1.0 / (2.0 * tileSizePixels.width)
        let inSampleHalfPixelOffsetY = 1.0 / (2.0 * tileSizePixels.height)
       
        shader.addUniform(SKUniform.init(name: "inSampleHalfPixelOffset", float: GLKVector2Make(Float(inSampleHalfPixelOffsetX), Float(inSampleHalfPixelOffsetY))))
        
        let node = SKSpriteNode(color: UIColor.white, size: coverageSizePoints)
        node.texture = tileTexture
        node.texture?.filteringMode = .nearest
        node.shader = shader
        
        return node
    }
}


