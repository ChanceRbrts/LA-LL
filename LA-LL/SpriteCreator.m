//
//  SpriteCreator.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SpriteCreator.h"
@implementation SpriteCreator
-(SKSpriteNode *)createNodeWithRed: (int)red green: (int)green blue: (int)blue alpha: (int)alpha x: (float)X y: (float)Y w: (float)W h: (float)H view: (SKView *)view{
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor: [NSColor colorWithRed: red/255.0 green: green/255.0 blue: blue/255.0 alpha: alpha/255.0] size:CGSizeMake(W*view.bounds.size.width/640,H*view.bounds.size.height/480)];
    node.position = CGPointMake((X+W/2)*view.bounds.size.width/640,(480-(Y+H/2))*view.bounds.size.height/480);
    return node;
}

-(SKLabelNode *)createNodeWithRed: (int)red green: (int)green blue: (int)blue alpha: (int)alpha x: (float)X y: (float)Y w: (float)W text: (NSString *) text font: (NSString *) font view: (SKView *)view{
    SKLabelNode *node = [[SKLabelNode alloc] initWithFontNamed: font];
    node.text = text;
    node.position = CGPointMake((X+W/2)*view.bounds.size.width/640,(480-(Y+W/2))*view.bounds.size.height/480);
    node.fontColor = [NSColor colorWithRed: red/255.0 green: green/255.0 blue: blue/255.0 alpha: alpha];
    node.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    node.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    node.fontSize = W*view.bounds.size.width/640;
    return node;
}
@end