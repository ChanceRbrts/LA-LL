//
//  Controls.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#include "Controls.h"

@implementation Controls

-(id) initWithMore{
    self = [super init];
    self.controlsPressed = [[NSMutableArray alloc] initWithObjects: @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
    self.controlsHeld = [[NSMutableArray alloc] initWithObjects: @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
    self.controlsLastPressed = [[NSMutableArray alloc] initWithObjects: @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
    return self;
}

-(void)checkPressed{
    for (int i = 0; i < [self.controlsPressed count]; i++){
        self.controlsLastPressed[i] = self.controlsPressed[i];
    }
}

-(void) keyPressedWithEvent:(NSEvent *)event {
    NSString *chara = [event charactersIgnoringModifiers];
    unichar keyDown = 0;
    for (int i = 0; i < [chara length]; i++){
        keyDown = [chara characterAtIndex:i];
        if (keyDown == NSLeftArrowFunctionKey){
            if ([self.controlsHeld[LEFT]  isEqual: @NO]){
                self.controlsPressed[LEFT] = @YES;
                self.controlsHeld[LEFT] = @YES;
            }
        }
        if (keyDown == NSRightArrowFunctionKey){
            if ([self.controlsHeld[RIGHT] isEqual: @NO]){
                self.controlsPressed[RIGHT] = @YES;
                self.controlsHeld[RIGHT] = @YES;
            }
        }
        if (keyDown == NSUpArrowFunctionKey){
            if ([self.controlsHeld[UP] isEqual: @NO]){
                self.controlsPressed[UP] = @YES;
                self.controlsHeld[UP] = @YES;
            }
        }
        if (keyDown == NSDownArrowFunctionKey){
            if ([self.controlsHeld[DOWN] isEqual: @NO]){
                self.controlsPressed[DOWN] = @YES;
                self.controlsHeld[DOWN] = @YES;
            }
        }
        if (keyDown == 'x'){
            if ([self.controlsHeld[A] isEqual: @NO]){
                self.controlsPressed[A] = @YES;
                self.controlsHeld[A] = @YES;
            }
        }
        if (keyDown == 'z'){
            if ([self.controlsHeld[B] isEqual: @NO]){
                self.controlsPressed[B] = @YES;
                self.controlsHeld[B] = @YES;
            }
        }
        if (keyDown == 's'){
            if ([self.controlsHeld[C] isEqual: @NO]){
                self.controlsPressed[C] = @YES;
                self.controlsHeld[C] = @YES;
            }
        }
        if (keyDown == 'a'){
            if ([self.controlsHeld[D] isEqual: @NO]){
                self.controlsPressed[D] = @YES;
                self.controlsHeld[D] = @YES;
            }
        }
        if (keyDown == 13){ //Return/Enter Key.
            if ([self.controlsHeld[START] isEqual: @NO]){
                self.controlsPressed[START] = @YES;
                self.controlsHeld[START] = @YES;
            }
        }
        if (keyDown == 27){ //Escape
            if ([self.controlsHeld[SELECT] isEqual: @NO]){
                self.controlsPressed[SELECT] = @YES;
                self.controlsHeld[SELECT] = @YES;
            }
        }
    }
}

-(void) keyReleasedWithEvent:(NSEvent *)event {
    NSString *chara = [event charactersIgnoringModifiers];
    unichar keyDown = 0;
    for (int i = 0; i < [chara length]; i++){
        keyDown = [chara characterAtIndex:i];
        if (keyDown == NSLeftArrowFunctionKey){
            self.controlsHeld[LEFT] = @NO;
        }
        if (keyDown == NSRightArrowFunctionKey){
            self.controlsHeld[RIGHT] = @NO;
        }
        if (keyDown == NSUpArrowFunctionKey){
            self.controlsHeld[UP] = @NO;
        }
        if (keyDown == NSDownArrowFunctionKey){
            self.controlsHeld[DOWN] = @NO;
        }
        if (keyDown == 'x'){
            self.controlsHeld[A] = @NO;
        }
        if (keyDown == 'z'){
            self.controlsHeld[B] = @NO;
        }
        if (keyDown == 's'){
            self.controlsHeld[C] = @NO;
        }
        if (keyDown == 'a'){
            self.controlsHeld[D] = @NO;
        }
        if (keyDown == 13){ //Return/Enter Key.
            self.controlsHeld[START] = @NO;
        }
        if (keyDown == 27){
            self.controlsHeld[SELECT] = @NO;
        }
    }
}

-(void) resetControls{
    for (int i = 0; i < [self.controlsPressed count]; i++){
        if ([self.controlsLastPressed[i] isEqual: @YES]){
            self.controlsPressed[i] = @NO;
            self.controlsLastPressed[i] = @NO;
        }
    }
}

@end