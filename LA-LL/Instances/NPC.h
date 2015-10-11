//
//  NPC.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef NPC_h
#define NPC_h
#include "Instance.h"
@interface NPC : Instance
/**@brief Creates the NPC with position.*/
-(id) initWithX:(float)X y:(float)Y num:(int)numb;
/**@brief Follow*/
@property int follow;
/**@brief What is the npc's number?*/
@property int num;
/**@brief Following X Array*/
@property NSMutableArray *followX;
/**@brief Following Y Array */
@property NSMutableArray *followY;
@end
#endif /* NPC_h */
