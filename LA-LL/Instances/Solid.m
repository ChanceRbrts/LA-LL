//
//  Solid.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Solid.h"
@implementation Solid
-(id)initWithX:(float)X y:(float)Y{
    self = [super initWithX: X y: Y];
    self.index = @"Solid";
    return self;
}
@end
