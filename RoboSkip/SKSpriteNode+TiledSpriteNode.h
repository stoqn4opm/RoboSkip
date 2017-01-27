//
//  SKSpriteNode+TiledSpriteNode.h
//  SKRepeatShader
//
//  Created by Stoyan Stoyanov on 1/26/17.
//  Copyright © 2017 HelpURock. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteNode (TiledSpriteNode)
+ (SKSpriteNode*) generateRepeatTiledImageNodeWithTile:(NSString*)tile size:(CGSize)backgroundSizePoints;
@end
