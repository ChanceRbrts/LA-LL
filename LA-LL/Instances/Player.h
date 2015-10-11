//
//  Player.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef Player_h
#define Player_h
#include "Instance.h"
#include "ControlsEnum.h"
#include "Cards.h"
#include "NPC.h"
@interface Player : Instance
/**@brief An update function that requires keyboard commands.
 @param con The controls that are being held.
 @param conPressed The controls that are being pressed.*/
-(void)updateWithControlsHeld: (NSArray *)con controlsPressed: (NSArray*)conPressed objects: (NSArray *)i;
/**@brief Draw another card.*/
-(void)drawCard: (int)card;
/**@brief Card One that the player is holding.*/
@property int cardOne;
/**@brief Card Two that the player is holding.*/
@property int cardTwo;
/**@brief Is the object checking if the object is in front of them?*/
@property bool check;
/**@brief Start the round.*/
@property bool startRound;
/**@brief Being followed.*/
@property int beingFollowed;
/**@brief Guard Guess.*/
@property int guardGuess;
/**@brief Protection by 4.*/
@property bool protect;
@end
#endif /* Player_h */
