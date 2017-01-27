//
//  TiledSKSpriteNode.swift
//  RoboSkip
//
//  Created by Stoyan Stoyanov on 1/27/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    
    static func generateRepeatTiledNodeWithTile(tile: String, backgroundSizePoints: CGSize) -> SKSpriteNode {
        
        // Load the tile as a SKTexture
        let tileTex = SKTexture.init(imageNamed: tile)
        
        // Dimensions of tile image
        let tileSizePixels = CGSize(width: tileTex.size().width, height: tileTex.size().height)
        
        // Generate tile that exactly covers the whole screen
        let screenScale = UIScreen.main.scale
        
        let coverageSizePixels = CGSize(width: backgroundSizePoints.width * screenScale, height: backgroundSizePoints.height * screenScale)
        
        let coverageSizePoints = CGSize(width: coverageSizePixels.width / screenScale, height: coverageSizePixels.height / screenScale)
        
        // Make shader and calculate uniforms to be used for pixel center calculations
        
        let infoDict = Bundle.main.infoDictionary
        let preferesOpenGLNum = infoDict!["PrefersOpenGL"] as! NSNumber
        let preferesOpenGL = preferesOpenGLNum.boolValue
        
        // OpenGL shader : 60 FPS
        // Metal shader :  39 FPS
        
        let shaderFilename = preferesOpenGL ? "shader_opengl.fsh" : "shader_metal.fsh"
        
        let shader = SKShader(fileNamed: shaderFilename)
        
        let outSampleHalfPixelOffsetX: Float = Float(1.0 / (2.0 * coverageSizePixels.width))
        let outSampleHalfPixelOffsetY: Float = Float(1.0 / (2.0 * coverageSizePixels.height))
        
        shader.addUniform(SKUniform(name: "outSampleHalfPixelOffset", float: GLKVector2Make(outSampleHalfPixelOffsetX, outSampleHalfPixelOffsetY)))
        
        // normalized width passed into mod operation
        let tileWidth = Float(tileSizePixels.width)
        let tileHeight = Float(tileSizePixels.height)
        
        shader.addUniform(SKUniform(name: "tileSize", float: GLKVector2Make(tileWidth, tileHeight)))
        
        // Tile pixel width and height
        let inSampleHalfPixelOffsetX = Float(1.0 / (2.0 * tileSizePixels.width))
        let inSampleHalfPixelOffsetY = Float(1.0 / (2.0 * tileSizePixels.height))
        
        shader.addUniform(SKUniform(name: "inSampleHalfPixelOffset", float: GLKVector2Make(inSampleHalfPixelOffsetX, inSampleHalfPixelOffsetY)))
        
        // Attach shader to node
        
        let node = SKSpriteNode(color: .white, size: coverageSizePoints)
        node.texture = tileTex
        node.texture?.filteringMode = .nearest
        node.shader = shader
        return node
    }
    
}
