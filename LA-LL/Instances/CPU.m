//
//  CPU.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CPU.h"
@implementation CPU
-(id) initWithX:(float)X y:(float)Y{
    self = [super initWithX:X y:Y];
    self.cardOne = 0;
    self.cardTwo = 0;
    self.turn = 0;
    self.decided = 0;
    self.guard = 0;
    self.saw = 0;
    self.guardGuess = 0;
    self.index = @"CPU";
    return self;
}

-(void)updateWithObjects:(NSArray *)i player:(Instance *)p{
    if (self.beingFollowed == 3){
        self.beingFollowed = 0;
    }
    if (self.guard == 0){
        for (int o = 0; o < i.count; o++){
            if ([((Instance *)i[o]).index isEqualToString: @"1"] && ((Player *)p).beingFollowed == 0){
                if (((NPC *)i[o]).follow > 0){
                    ((NPC *)i[o]).follow = 0;
                }
            }
        }
    }
    if (self.turn == 2){
        self.decided = 0;
        self.guard = 0;
        for (int o = 0; o < i.count; o++){
            if ([((Instance *)i[o]).index isEqualToString: @"Cards"]){
                if (self.x > ((Cards *)i[o]).x){
                    self.dX = -4;
                }
                else if (self.x < ((Cards *)i[o]).x){
                    self.dX = 4;
                }
                else{
                    self.dX = 0;
                }
                if (self.y > ((Cards *)i[o]).y){
                    self.dY = -4;
                }
                else if (self.y < ((Cards *)i[o]).y){
                    self.dY = 4;
                }
                else{
                    self.dY = 0;
                }
                [self collisionWithInstance: i[o]];
            }
        }
    }
    else if (self.turn == 3){
        if (self.decided == 0 && self.guard == 0){
            [self aiWithPlayer: p objects: i];
        }
        else if (self.decided != 0){
            NPC *decide;
            for (int o = 0; o < i.count; o++){
                if ([((Instance *)i[o]).index isEqualToString: [NSString stringWithFormat: @"%d", self.decided]]){
                    decide = ((NPC *)i[o]);
                }
            }
            if (self.x > decide.x){
                self.dX = -4;
            }
            else if (self.x < decide.x){
                self.dX = 4;
            }
            else{
                self.dX = 0;
            }
            if (self.y > decide.y){
                self.dY = -4;
            }
            else if (self.y < decide.y){
                self.dY = 4;
            }
            else{
                self.dY = 0;
            }
        }
        else if (self.guard != 0){
            NPC *decide;
            for (int o = 0; o < i.count; o++){
                if ([((Instance *)i[o]).index isEqualToString: [NSString stringWithFormat: @"%d", self.guard]]){
                    decide = ((NPC *)i[o]);
                }
            }
            if (self.x > decide.x){
                self.dX = -4;
            }
            else if (self.x < decide.x){
                self.dX = 4;
            }
            else{
                self.dX = 0;
            }
            if (self.y > decide.y){
                self.dY = -4;
            }
            else if (self.y < decide.y){
                self.dY = 4;
            }
            else{
                self.dY = 0;
            }
        }
    }
    else{
        self.dX = 0;
        self.dY = 0;
    }
    self.guardGuess = 0;
}

-(void) aiWithPlayer: (Instance *)p objects: (NSArray *)o{
    if (self.cardOne == 4 || self.cardTwo == 4){
        self.decided = 4;
    }
    else if ((self.cardOne == 7 && (self.cardTwo == 5 || self.cardTwo == 6)) || (self.cardTwo == 7 && (self.cardOne == 5 || self.cardOne == 6))){
        self.decided = 7;
    }
    else if ((self.cardOne == 3 && self.cardTwo >= 5) || (self.cardTwo == 3 && self.cardOne >= 5)){
        self.decided = 3;
    }
    else if ((self.cardOne == 3) && self.cardTwo < 5){
        self.decided = self.cardTwo;
    }
    else if ((self.cardTwo == 3) && self.cardOne < 3){
        self.decided = self.cardOne;
    }
    else if (self.cardOne == 8){
        self.decided = self.cardTwo;
    }
    else if (self.cardTwo == 8){
        self.decided = self.cardOne;
    }
    else if (self.cardOne == 2 || self.cardTwo == 2){
        self.decided = 2;
    }
    else if (self.cardOne == 1 || self.cardOne == 1){
        self.decided = 1;
    }
    else if (self.cardOne > self.cardTwo){
        self.decided = self.cardTwo;
    }
    else{
        self.decided = self.cardOne;
    }
    if (self.decided == 1){
        if (self.saw == ((Player *)p).cardOne){ //If the player did not get rid of the card.
            self.guard = self.saw;
        }
        else{
            for (int i = 0; i < o.count; i++){
                if ([((Instance *)o[i]).index isEqualToString: @"Cards"]){
                    NSMutableArray *cardsToPick = [[NSMutableArray alloc] init];
                    for (int j = 0; j < ((Cards *)o[i]).cards.count; j++){
                        [cardsToPick addObject: ((Cards*)o[i]).cards[j]];
                    }
                    [cardsToPick addObject: [NSNumber numberWithInt: ((Player *)p).cardOne]];
                    NSNumber *q = ((NSNumber *)cardsToPick[arc4random()%cardsToPick.count]);
                    self.guard = [q intValue];
                }
            }
        }
    }
}

-(void)drawCard: (int)card{
    if (self.cardOne == 0){
        self.cardOne = card;
    }
    else if (self.cardTwo == 0){
        self.cardTwo = card;
    }
}

-(NSArray *) drawWithViewX: (float) vX viewY: (float) vY{
    return @[[NSNumber numberWithInt: 255], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: self.x-vX], [NSNumber numberWithFloat: self.y-vY], [NSNumber numberWithFloat: self.w], [NSNumber numberWithFloat: self.h]];
}

-(void)extraCollisionWithDegree:(int)dg instance:(Instance *)i{
    if ([i.index isEqualToString: [NSString stringWithFormat: @"%d", self.decided]]){
        if ([i.index isEqualToString: @"4"]){
            self.protect = true;
        }
        else if ([i.index isEqualToString: @"1"]){
            ((NPC *)i).follow = 2;
            self.beingFollowed = 1;
        }
        else{
            self.beingFollowed = self.decided;
        }
        if (self.cardOne == self.decided){
            self.cardOne = self.cardTwo;
        }
        self.cardTwo = 0;
        self.decided = 0;
    }
    else if ([i.index isEqualToString: [NSString stringWithFormat: @"%d", self.guard]]){
        self.guardGuess = self.guard;
        self.guard = 0;
        
    }
}
@end