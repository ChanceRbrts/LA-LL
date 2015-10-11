//
//  CPU.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef CPU_h
#define CPU_h
#include "Instance.h"
#include "Cards.h"
#include "NPC.h"
@interface CPU : Instance
/**@brief The first card the CPU has.*/
@property int cardOne;
/**@brief The second card the CPU has.*/
@property int cardTwo;
/**@brief His turn?*/
@property int turn;
/**@brief Draw another card.*/
-(void)drawCard: (int)card;
/**@brief Decide whom to go to.*/
-(void) aiWithPlayer: (Instance *)p objects: (NSArray *)o;
/**@brief Protection by 4.*/
@property bool protect;
/**@brief Has decided.*/
@property int decided;
/**@brief Who are you guessing for guard?*/
@property int guard;
/**@brief Guard's Guess*/
 @property int guardGuess;
/**@brief What 2 Saw*/
@property int saw;
/**@brief Being followed.*/
@property int beingFollowed;
@end
#endif /* CPU_h */
