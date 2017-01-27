//
//  SKSpriteNode+TiledSpriteNode.m
//  SKRepeatShader
//
//  Created by Stoyan Stoyanov on 1/26/17.
//  Copyright © 2017 HelpURock. All rights reserved.
//

#import "SKSpriteNode+TiledSpriteNode.h"

@implementation SKSpriteNode (TiledSpriteNode)

// Generate a repeating tile pattern in a SKSpriteNode using an OpenGL shader

+ (SKSpriteNode*) generateRepeatTiledImageNodeWithTile:(NSString*)tile size:(CGSize)backgroundSizePoints
{
    NSString *textureFilename = tile;
    
    // Load the tile as a SKTexture
    
    SKTexture *tileTex = [SKTexture textureWithImageNamed:textureFilename];
    
    // Dimensions of tile image
    
    CGSize tileSizePixels = CGSizeMake(tileTex.size.width, tileTex.size.height); // tile texture dimensions
    
    NSLog(@"tile size in pixels %d x %d", (int)tileSizePixels.width, (int)tileSizePixels.height);
    
    // Generate tile that exactly covers the whole screen
    
    float screenScale = [UIScreen mainScreen].scale;
    
    CGSize coverageSizePixels = CGSizeMake(backgroundSizePoints.width * screenScale, backgroundSizePoints.height * screenScale);
    
    CGSize coverageSizePoints = CGSizeMake(coverageSizePixels.width / screenScale, coverageSizePixels.height / screenScale);
    
    // Make shader and calculate uniforms to be used for pixel center calculations
    
    SKShader* shader;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSDictionary *infoDict = mainBundle.infoDictionary;
    NSNumber *preferesOpenGLNum = infoDict[@"PrefersOpenGL"];
    BOOL preferesOpenGL = [preferesOpenGLNum boolValue];
    
    NSString *shaderFilename;
    
    // OpenGL shader : 60 FPS
    // Metal shader :  39 FPS
    
    if (preferesOpenGL) {
        shaderFilename = @"shader_opengl.fsh";
    } else {
        shaderFilename = @"shader_metal.fsh";
    }
    
    shader = [SKShader shaderWithFileNamed:shaderFilename];
    assert(shader);
    
    float outSampleHalfPixelOffsetX = 1.0f / (2.0f * ((float)coverageSizePixels.width));
    float outSampleHalfPixelOffsetY = 1.0f / (2.0f * ((float)coverageSizePixels.height));
    
    [shader addUniform:[SKUniform uniformWithName:@"outSampleHalfPixelOffset" floatVector2:GLKVector2Make(outSampleHalfPixelOffsetX, outSampleHalfPixelOffsetY)]];
    
    // normalized width passed into mod operation
    
    float tileWidth = tileSizePixels.width;
    float tileHeight = tileSizePixels.height;
    
    [shader addUniform:[SKUniform uniformWithName:@"tileSize" floatVector2:GLKVector2Make(tileWidth, tileHeight)]];
    
    // Tile pixel width and height
    
    float inSampleHalfPixelOffsetX = 1.0f / (2.0f * ((float)tileSizePixels.width));
    float inSampleHalfPixelOffsetY = 1.0f / (2.0f * ((float)tileSizePixels.height));
    
    [shader addUniform:[SKUniform uniformWithName:@"inSampleHalfPixelOffset" floatVector2:GLKVector2Make(inSampleHalfPixelOffsetX, inSampleHalfPixelOffsetY)]];
    
    // Attach shader to node
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:coverageSizePoints];
    
    node.texture = tileTex;
    
    node.texture.filteringMode = SKTextureFilteringNearest;
    
    node.shader = shader;
    
    return node;
}

@end
