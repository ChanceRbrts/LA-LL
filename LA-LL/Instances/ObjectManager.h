//
//  ObjectManager.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef ObjectManager_h
#define ObjectManager_h
#include "Instance.h"
#include "Solid.h"
#include "Player.h"
#include "PartyRoom.h"
#include "NPC.h"
#include "Cards.h"
#include "Starter.h"
#include "CPU.h"
/**@brief The object that updates/gets draw commands of the instances.*/
@interface objManager : NSObject
/**@brief The camera's x position. (Left side of screen)*/
@property float viewX;
/**@brief The camera's y posiiton. (Right side of screen)*/
@property float viewY;
/**@brief The 480-pixel row that is in the middle of the screen.*/
@property int mainRow;
/**@brief The 640-pixel collumn that is in the middle of the screen.*/
@property int mainCol;
/**@brief The current room/layer.*/
@property int room;
/**@brief Party Room!*/
@property PartyRoom *pr;
/**@brief The objects in the room.*/
@property NSArray *obj;
/**@brief The player*/
@property Player *player;
/**@brief The turn.*/
@property int turn;
/**@brief The winner!*/
@property int winner;
/**@brief Card Display.*/
@property int card;
/**@brief Card Display for how long?*/
@property int cardDisplayTimer;
/**@brief Displaying the winner message.*/
@property int winnerTime;
/**@brief What players are protected?*/
@property int protect;
/**@brief Updating the instances managed.*/
-(void)updateWithControlsHeld: (NSArray *)con controlsPressed: (NSArray*)conPressed;
/**@brief Turn a Room Array into instances.*/
-(NSArray *)buildRoom: (NSArray *)room;
/**@brief Change viewX and viewY*/
-(void)changeViewXandYWithInstance: (Instance *)i;
/**@brief Get drawing instructions.*/
-(NSArray *)draw;
@end

#endif /* ObjectManager_h */
