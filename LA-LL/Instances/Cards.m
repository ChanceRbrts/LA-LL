//
//  Cards.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Cards.h"
@implementation Cards
-(id) initWithX:(float)X y:(float)Y{
    self = [super initWithX:X y:Y];
    self.allCards = @[@1,@1,@1,@1,@1,@2,@2,@3,@3,@4,@4,@5,@5,@6,@7,@8];
    self.index = @"Cards";
    self.type = @"Transparent";
    self.won = 1;
    self.start = false;
    self.turn = 0;
    self.compare = false;
    return self;
}

-(void) startRoundWithPlayer: (Instance *)p P2: (Instance *)c{
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.allCards.count; i++){
        bool contin = false;
        int v = 0;
        while (contin == false){
            v = arc4random()%self.allCards.count;
            contin = true;
            for (int j = 0; j < a.count; j++){
                if ([(NSNumber *)a[j] intValue] == v){
                    contin = false;
                }
            }
        }
        [a addObject: [NSNumber numberWithInt: v]];
    }
    self.cards = [[NSMutableArray alloc] init];
    self.p1cards = [[NSMutableArray alloc] init];
    self.p2cards = [[NSMutableArray alloc] init];
    for (int i = 0; i < a.count-3; i++){ //-3 as part of the rules of Love Letter.
        int valueToGet = [a[i] intValue];
        [self.cards addObject: (NSNumber *)(self.allCards[valueToGet])];
    }
    [self drawCardForPlayer:p playerNum: 1];
    [self drawCardForPlayer: c playerNum: 2];
    if (self.won == 1){
        [self drawCardForPlayer:p playerNum: 1];
    }
    else{
        [self drawCardForPlayer: c playerNum: 2];
    }
    self.start = false;
}

-(bool) drawCardForPlayer: (Instance *)p playerNum:(int)num{
    if (self.cards.count  == 0) return false;
    if (num == 1){
        [(Player *)p drawCard: [(NSNumber *)self.cards[0] intValue]];
        [self.p1cards addObject: self.cards[0]];
    }
    if (num == 2){
        [(CPU *)p drawCard: [(NSNumber *)self.cards[0] intValue]];
        [self.p2cards addObject: self.cards[0]];
    }
    [self.cards removeObjectAtIndex: 0];
    return true;
}

-(void)extraCollisionWithDegree:(int)dg instance:(Instance *)i{
    if ([i.index isEqualToString:@"Player"] && ((Player *)i).cardTwo == 0 && self.turn == 0){
        if (![self drawCardForPlayer:i playerNum:1]){
            self.compare = true;
        }
    }
    if ([i.index isEqualToString:@"CPU"] && ((CPU *)i).cardTwo == 0 && self.turn == 2){
        if (![self drawCardForPlayer:i playerNum:2]){
            self.compare = true;
        }
    }
}

-(int) victoryWithPlayer: (Instance *)p P2: (Instance *)c{
    if (((Player *)p).cardOne > ((CPU *)c).cardOne){
        return 1;
    }
    if (((Player *)p).cardOne < ((CPU *)c).cardOne){
        return 2;
    }
    int p1Score = 0;
    int p2Score = 0;
    for (int i = 0; i < self.p1cards.count; i++){
        p1Score += [(NSNumber *)self.p1cards[i] intValue];
    }
    for (int i = 0; i < self.p2cards.count; i++){
        p2Score += [(NSNumber *)self.p2cards[i] intValue];
    }
    return 1+(p2Score > p1Score);
}

-(NSArray *) drawWithViewX:(float)vX viewY:(float)vY{
    return @[[NSNumber numberWithInt: 100], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: self.x-vX], [NSNumber numberWithFloat: self.y-vY], [NSNumber numberWithFloat: self.w], [NSNumber numberWithFloat: self.h]];
}

-(void) reset{
    self.cards = [[NSMutableArray alloc] init];
}

@end