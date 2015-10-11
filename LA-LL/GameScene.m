//
//  GameScene.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright (c) 2015 Chance Roberts. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.c = [[Controls alloc] initWithMore];
    self.OBJMAN = [[objManager alloc] init];
}

-(void)keyDown:(NSEvent *)theEvent{
    [self.c keyPressedWithEvent:theEvent];
}

-(void)keyUp:(NSEvent *)theEvent{
    [self.c keyReleasedWithEvent:theEvent];
}

-(void)update:(CFTimeInterval)currentTime {
    [self.OBJMAN updateWithControlsHeld: self.c.controlsHeld controlsPressed:self.c.controlsPressed];
    [self.c resetControls];
    [self.c checkPressed];
    [self setupDrawWithInstructions: [self.OBJMAN draw]];
}

-(void) setupDrawWithInstructions: (NSArray *)instru{
    [self removeAllChildren];
    SpriteCreator *sc = [[SpriteCreator alloc] init];
    for (int i = 0; i < instru.count; i++){
        if (((NSArray *)instru[i]).count == 8){
            [self addChild: [sc createNodeWithRed:[((NSNumber *)instru[i][0]) intValue] green:[((NSNumber *)instru[i][1]) intValue] blue:[((NSNumber *)instru[i][2]) intValue] alpha:[((NSNumber *)instru[i][3]) intValue] x:[((NSNumber *)instru[i][4]) floatValue] y:[((NSNumber *)instru[i][5]) floatValue] w:[((NSNumber *)instru[i][6]) floatValue] h:[((NSNumber *)instru[i][7]) floatValue] view:self.view]];
        }
        else if (((NSArray *)instru[i]).count == 9){
            [self addChild: [sc createNodeWithRed:[((NSNumber *)instru[i][0]) intValue] green:[((NSNumber *)instru[i][1]) intValue] blue:[((NSNumber *)instru[i][2]) intValue] alpha:[((NSNumber *)instru[i][3]) intValue] x:[((NSNumber *)instru[i][4]) floatValue] y:[((NSNumber *)instru[i][5]) floatValue] w:[((NSNumber *)instru[i][6]) floatValue]text:(NSString*)instru[i][7] font:(NSString*)instru[i][8] view:self.view]];
        }
    }
}


@end
