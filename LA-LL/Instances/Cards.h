//
//  Cards.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef Cards_h
#define Cards_h
#include "Instance.h"
#include "Player.h"
#include "CPU.h"
@interface Cards: Instance
/**@brief All the cards.*/
@property NSArray *allCards;
/**@brief All the cards in play.*/
@property NSMutableArray *cards;
/**@brief All the cards played by P1.*/
@property NSMutableArray *p1cards;
/**@brief All the cards played by CPU/P2.*/
@property NSMutableArray *p2cards;
/**@brief The last person to win.*/
@property int won;
/**@brief The current turn.*/
@property int turn;
/**@brief Start the round?*/
@property bool start;
/**@brief Compare.*/
@property bool compare;
/**@brief Start the round.*/
-(void) startRoundWithPlayer: (Instance *)p P2: (Instance *)c;
/**@brief Draw a card for the player.*/
-(bool) drawCardForPlayer: (Instance *)p playerNum: (int)num;
/**@brief Reset the round.*/
-(void) reset;
/**@brief Decide the winner at the end of the round!*/
-(int) victoryWithPlayer: (Instance *)p P2: (Instance *)c;
@end
#endif /* Cards_h */
