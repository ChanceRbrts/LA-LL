//
//  Player.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Player.h"
@implementation Player
-(id)initWithX:(float)X y:(float)Y{
    self = [super initWithX:X y:Y];
    self.cardOne = 0;
    self.cardTwo = 0;
    self.index = @"Player";
    self.check = false;
    self.startRound = false;
    self.beingFollowed = 0;
    self.guardGuess = 0;
    self.protect = false;
    return self;
}

-(void) updateWithControlsHeld:(NSArray *)con controlsPressed:(NSArray *)conPressed objects: (NSArray *)i{
    if (self.beingFollowed == 3){
        self.beingFollowed = 0;
    }
    if ([con[LEFT] isEqual: @YES] && [con[RIGHT] isEqual: @NO]){
        self.dX = -4;
    }
    else if ([con[RIGHT] isEqual: @YES] && [con[LEFT] isEqual: @NO]){
        self.dX = 4;
    }
    else{
        self.dX = 0;
    }
    if ([con[UP] isEqual: @YES] && [con[DOWN] isEqual: @NO]){
        self.dY = -4;
    }
    else if ([con[DOWN] isEqual: @YES] && [con[UP] isEqual: @NO]){
        self.dY = 4;
    }
    else{
        self.dY = 0;
    }
    if (self.dX > 0){
        if (self.dY > 0){
            self.direc = 315;
        }
        else if (self.dY < 0){
            self.direc = 45;
        }
        else{
            self.direc = 0;
        }
    }
    else if (self.dX < 0){
        if (self.dY > 0){
            self.direc = 225;
        }
        else if (self.dY < 0){
            self.direc = 135;
        }
        else{
            self.direc = 180;
        }
    }
    else{
        if (self.dY > 0){
            self.direc = 270;
        }
        else if (self.dY < 0){
            self.direc = 90;
        }
    }
    if ([conPressed[START] isEqual: @YES] || [conPressed[A] isEqual: @YES]){
        self.check = true;
        float prevDX = self.dX;
        float prevDY = self.dY;
        if (self.direc == 0 || self.direc == 45 || self.direc == 315){
            self.dX = 4;
        }
        else if (self.direc == 180 || self.direc == 180 || self.direc == 225){
            self.dX = -4;
        }
        else{
            self.dX = 0;
        }
        if (self.direc == 45 || self.direc == 90 || self.direc == 135){
            self.dY = -4;
        }
        else if (self.direc == 225 || self.direc == 270 || self.direc == 315){
            self.dY = 4;
        }
        else{
            self.dY = 0;
        }
        for (int o = 0; o < i.count; o++){
            [self collisionWithInstance: (Instance *)i[o]];
        }
        if (self.startRound){
            for (int o = 0; o < i.count; o++){
                if ([((Instance *)i[o]).index isEqualToString: @"Cards"]){
                    ((Cards *)i[o]).start = true;
                }
            }
            self.startRound = false;
        }
        self.dX = prevDX;
        self.dY = prevDY;
        self.check = false;
        for (int o = 0; o < i.count; o++){
            if ([((Instance *)i[o]).index isEqualToString: @"1"] && ((NPC *)i[o]).follow == 1 && self.beingFollowed == 0){
                ((NPC *)i[o]).follow = 0;
            }
        }
    }
}

-(void) drawCard:(int)card{
    if (self.cardOne == 0){
        self.cardOne = card;
    }
    else if (self.cardTwo == 0){
        self.cardTwo = card;
    }
}

-(NSArray *) drawWithViewX: (float) vX viewY: (float) vY{
    return @[[NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: self.x-vX], [NSNumber numberWithFloat: self.y-vY], [NSNumber numberWithFloat: self.w], [NSNumber numberWithFloat: self.h]];
}

-(void) extraCollisionWithDegree:(int)dg instance:(Instance *)i{
    if (self.check){
        i.direc = 360-self.direc;
        if ([i.index isEqualToString: @"1"] || [i.index isEqualToString: @"2"] || [i.index isEqualToString: @"3"] || [i.index isEqualToString: @"4"] || [i.index isEqualToString: @"5"] || [i.index isEqualToString: @"6"] || [i.index isEqualToString: @"7"]){
            if (self.beingFollowed == 1 && ![i.index isEqualToString: @"1"]){
                self.guardGuess = [i.index intValue];
                self.beingFollowed = 0;
            }
            else{
                if ((self.cardOne == [i.index intValue] || self.cardTwo == [i.index intValue]) && self.cardOne != 0 && self.cardTwo != 0){
                    if (self.cardOne == [i.index intValue]){
                        self.cardOne = self.cardTwo;
                        self.cardTwo = 0;
                    }
                    if (self.cardTwo == [i.index intValue]){
                        self.cardTwo = 0;
                    }
                    if ([i.index isEqualToString: @"1"]){
                        ((NPC *)i).follow = 1;
                        self.beingFollowed = 1;
                    }
                    else if ([i.index isEqualToString: @"2"]){
                        self.beingFollowed = 2;
                    }
                    else if ([i.index isEqualToString: @"3"]){
                        self.beingFollowed = 3;
                    }
                    else if ([i.index isEqualToString: @"4"]){
                        self.protect = true;
                    }
                    else if ([i.index isEqualToString: @"5"]){
                        if (self.cardOne != 7){
                            self.beingFollowed = 5;
                        }
                        else{
                            self.cardTwo = 5;
                        }
                    }
                    else if([i.index isEqualToString: @"6"]){
                        if (self.cardOne != 7){
                            self.beingFollowed = 6;
                        }
                        else{
                            self.cardTwo = 6;
                        }
                    }
                    else if([i.index isEqualToString: @"8"]){
                        self.beingFollowed = 8;
                    }
                    
                }
            }
        }
        if ([i.index isEqualToString: @"Starter"] && self.cardOne == 0){
            self.startRound = true;
        }
        if ([i.index isEqualToString: @"CPU"] && self.beingFollowed == 5 && !((CPU *)i).protect){
            ((CPU *)i).cardOne = 0;
        }
    }
}
@end