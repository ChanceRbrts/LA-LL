//
//  Starter.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Starter.h"
@implementation Starter
-(id) initWithX:(float)X y:(float)Y{
    self = [super initWithX:X y:Y];
    self.index = @"Starter";
    return self;
}
-(NSArray *) drawWithViewX:(float)vX viewY:(float)vY{
    return @[[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: self.x-vX], [NSNumber numberWithFloat: self.y-vY], [NSNumber numberWithFloat: self.w], [NSNumber numberWithFloat: self.h]];
}
@end