//
//  NPC.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "NPC.h"
@implementation NPC
-(id) initWithX:(float)X y:(float)Y num:(int)numb{
    self = [self initWithX:X y:Y];
    self.num = numb;
    self.index = [NSString stringWithFormat: @"%d", self.num];
    self.followX = [[NSMutableArray alloc] init];
    self.followY = [[NSMutableArray alloc] init];
    return self;
}

-(void) updateWithObjects:(NSArray *)i player:(Instance *)p{
    [super updateWithObjects:i player:p];
    if (self.follow == 1 && self.followX.count > 0){
        bool goAhead = true;
        while (goAhead){
            if (p.x != [((NSNumber *)self.followX[self.followX.count-1]) floatValue] || p.y != [((NSNumber *)self.followY[self.followY.count-1]) floatValue]){
                [self.followX addObject: [NSNumber numberWithFloat: p.x]];
                [self.followY addObject: [NSNumber numberWithFloat: p.y]];
            }
            if (self.x > [((NSNumber *)self.followX[0]) floatValue]){
                self.dX = -4;
            }
            else if (self.x < [((NSNumber *)self.followX[0]) floatValue]){
                self.dX = 4;
            }
            else{
                self.dX = 0;
            }
            if (self.y > [((NSNumber *)self.followY[0]) floatValue]){
                self.dY = -4;
            }
            else if (self.y < [((NSNumber *)self.followY[0]) floatValue]){
                self.dY = 4;
            }
            else{
                self.dY = 0;
            }
            if (self.dX == 0 && self.dY == 0){
                [self.followX removeObjectAtIndex: 0];
                [self.followY removeObjectAtIndex: 0];
            }
            else{
                goAhead = false;
            }
        }
    }
    else if (self.follow == 1){
        [self.followX addObject: [NSNumber numberWithFloat: p.x]];
        [self.followY addObject: [NSNumber numberWithFloat: p.y]];
    }
    else{
        Instance *check;
        for (int o = 0; o < i.count; o++){
            if ([((Instance *)i[o]).index isEqualToString: @"CPU"]){
                check = ((Instance *)i[o]);
            }
        }
        if (self.follow == 2 && self.followX.count > 0){
            bool goAhead = true;
            while (goAhead){
                if (check.x != [((NSNumber *)self.followX[self.followX.count-1]) floatValue] || check.y != [((NSNumber *)self.followY[self.followY.count-1]) floatValue]){
                    [self.followX addObject: [NSNumber numberWithFloat: check.x]];
                    [self.followY addObject: [NSNumber numberWithFloat: check.y]];
                }
                if (self.x > [((NSNumber *)self.followX[0]) floatValue]){
                    self.dX = -4;
                }
                else if (self.x < [((NSNumber *)self.followX[0]) floatValue]){
                    self.dX = 4;
                }
                else{
                    self.dX = 0;
                }
                if (self.y > [((NSNumber *)self.followY[0]) floatValue]){
                    self.dY = -4;
                }
                else if (self.y < [((NSNumber *)self.followY[0]) floatValue]){
                    self.dY = 4;
                }
                else{
                    self.dY = 0;
                }
                if (self.dX == 0 && self.dY == 0){
                    [self.followX removeObjectAtIndex: 0];
                    [self.followY removeObjectAtIndex: 0];
                }
                else{
                    goAhead = false;
                }
            }
        }
        else if (self.follow == 2){
            [self.followX addObject: [NSNumber numberWithFloat: p.x]];
            [self.followY addObject: [NSNumber numberWithFloat: p.y]];
        }
        else{
            [self.followX removeAllObjects];
            [self.followY removeAllObjects];
            self.dX = 0;
            self.dY = 0;
        }
    }
}

-(void)finishUpdate{
    [super finishUpdate];
}

-(NSArray *) drawWithViewX: (float) vX viewY: (float) vY{
    return @[[NSNumber numberWithInt: (int)((self.num-1)*(255/7.0))], [NSNumber numberWithInt: (int)((self.num-1)*(255/7.0))], [NSNumber numberWithInt: (int)((self.num-1)*(255/7.0))], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: self.x-vX], [NSNumber numberWithFloat: self.y-vY], [NSNumber numberWithFloat: self.w], self.index, @"Courier-Bold"];
}
@end