//
//  PartyRoom.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "PartyRoom.h"
@implementation PartyRoom
-(id)init{
    self = [super init];
    self.room = @[@"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSS",
                  @"S0000000000000000000000000000S",
                  @"S0000200000000003000000040000S",
                  @"S0000000000000000000000000000S",
                  @"S0000000000000000000000000000S",
                  @"S0000000000000000000000000000S",
                  @"S0000000000000000000000000000S",
                  @"S00100000000000P000U000000500S",
                  @"S0000000000000000000000000000S",
                  @"S0000000000000000000080000000S",
                  @"S0000000000000000000000000000S",
                  @"S0000000000000000000000000000S",
                  @"S0000700000000C00000000060000S",
                  @"S0000000000000000000000000000S",
                  @"SSSSSSSSSQSSSSSSSSSSSSSSSSSSSS"];
    return self;
}
@end