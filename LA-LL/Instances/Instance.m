//
//  Instance.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Instance.h"
@implementation Instance
-(id)initWithX:(float)X y:(float)Y{
    self = [super init];
    self.x = X*32;
    self.y = Y*32;
    self.w = 32;
    self.h = 32;
    self.dX = 0;
    self.dY = 0;
    self.direc = 270;
    self.type = @"Solid";
    self.index = @"Instance";
    return self;
}

-(void) extraCollisionWithDegree:(int)dg instance: (Instance *)i{}

-(void) collisionWithInstance:(Instance *)i{
    if ([self.type isEqualToString: @"Solid"] && [i.type isEqualToString: @"Solid"]){
        if (self.x+self.dX+self.w > i.x+i.dX && self.x+self.w <= i.x && self.y+self.dY+self.h > i.y+i.dY && self.y+self.dY < i.y+i.dY+i.h){
            self.dX = 0;
            i.dX = 0;
            self.x = i.x-self.w;
            [self extraCollisionWithDegree:0 instance: i];
            [i extraCollisionWithDegree:180 instance: self];
        }
        if (self.x+self.dX < i.x+i.dX+i.w && self.x >= i.x+i.w && self.y+self.dY+self.h > i.y+i.dY && self.y+self.dY < i.y+i.dY+i.h){
            self.dX = 0;
            i.dX = 0;
            self.x = i.x+i.w;
            [self extraCollisionWithDegree: 180 instance: i];
            [i extraCollisionWithDegree: 0 instance: self];
        }
        if (self.y+self.dY+self.h > i.y+i.dY && self.y+self.h <= i.y && self.x+self.dX+self.w > i.x+i.dX && self.x+self.dX < i.x+i.dX+i.w){
            self.dY = 0;
            i.dY = 0;
            self.y = i.y-self.h;
            [self extraCollisionWithDegree:270 instance: i];
            [i extraCollisionWithDegree:90 instance: self];
        }
        if (self.y+self.dY < i.y+i.dY+i.h && self.y >= i.y+i.h && self.x+self.dX+self.w > i.x+i.dX && self.x+self.dX < i.x+i.dX+i.w){
            self.dY = 0;
            i.dY = 0;
            self.y = i.y+i.h;
            [self extraCollisionWithDegree: 90 instance: i];
            [i extraCollisionWithDegree: 270 instance: self];
        }
        if (self.y+self.dY+self.h > i.y+i.dY && self.y+self.dY < i.y+i.h+i.dY && self.x+self.dX+self.w > i.x+i.dX && self.x+self.dX < i.x+i.w+i.dX){
            [self extraCollisionWithDegree: -1 instance: i];
            [i extraCollisionWithDegree: -1 instance: self];
        }
    }
    if (self.y+self.dY+self.h > i.y+i.dY && self.y+self.dY < i.y+i.h+i.dY && self.x+self.dX+self.w > i.x+i.dX && self.x+self.dX < i.x+i.w+i.dX){
        [self extraCollisionWithDegree: -1 instance: i];
        [i extraCollisionWithDegree: -1 instance: self];
    }
}

-(void) updateWithObjects: (NSArray *)i player: (Instance *)p{}

-(void) finishUpdate{
    self.x += self.dX;
    self.y += self.dY;
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
}

-(NSArray *) drawWithViewX: (float) vX viewY: (float) vY{
    return @[[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: self.x-vX], [NSNumber numberWithFloat: self.y-vY], [NSNumber numberWithFloat: self.w], [NSNumber numberWithFloat: self.h]];
}
@end