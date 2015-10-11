//
//  SpriteCreator.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef SpriteCreator_h
#define SpriteCreator_h
#import <SpriteKit/SpriteKit.h>
/**@brief Responsible for creating SpriteNodes and putting them on the view.*/
@interface SpriteCreator : NSObject
/**@brief Creates a SKSprite Node based on parameters given via the NSArrays.*/
-(SKSpriteNode *)createNodeWithRed: (int)red green: (int)green blue: (int)blue alpha: (int)alpha x: (float)X y: (float)Y w: (float)W h: (float)H view: (SKView *)view;
-(SKLabelNode *)createNodeWithRed: (int)red green: (int)green blue: (int)blue alpha: (int)alpha x: (float)X y: (float)Y w: (float)W text: (NSString *) text font: (NSString *) font view: (SKView *)view;
@end
#endif /* SpriteCreator_h */
