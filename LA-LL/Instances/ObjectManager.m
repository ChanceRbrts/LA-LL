//
//  ObjectManager.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ObjectManager.h"
@implementation objManager
-(id)init{
    self.pr = [[PartyRoom alloc] init];
    self.obj = [self buildRoom: self.pr.room];
    self.room = 1;
    self.viewX = 0;
    self.viewY = 0;
    self.turn = 0;
    self.winner = 0;
    self.winnerTime = 0;
    self.protect = 0;
    return self;
}

-(void)changeViewXandYWithInstance: (Instance *)i{
    self.viewX = i.x-320;
    if (self.viewX < 0){
        self.viewX = 0;
    }
    if (self.viewX > 960-640){
        self.viewX = 960-640;
    }
    self.viewY = i.y-240;
    if (self.viewY < 0){
        self.viewY = 0;
    }
    if (self.viewY > 0){
        self.viewY = 0;
    }
}

-(void)updateWithControlsHeld: (NSArray *)con controlsPressed: (NSArray*)conPressed{
    if (self.cardDisplayTimer > 0){
        self.cardDisplayTimer--;
    }
    [self.player updateWithControlsHeld:con controlsPressed:conPressed objects: self.obj];
    for (int i = 0; i < self.obj.count; i++){
        if ([((Instance *)self.obj[i]).index isEqualToString: @"Cards"] && ((Cards *)self.obj[i]).start){
            for (int j = 0; j < self.obj.count; j++){
                if ([((Instance *)self.obj[j]).index isEqualToString: @"CPU"]){
                    [((Cards *)self.obj[i]) startRoundWithPlayer:self.player P2:((CPU *)self.obj[j])];
                }
            }
            ((Cards *)self.obj[i]).turn = self.turn;
        }
        [((Instance *)self.obj[i]) updateWithObjects: self.obj player: self.player];
    }
    for (int i = 0; i < self.obj.count; i++){
        [self.player collisionWithInstance: ((Instance *)(self.obj[i]))];
        if (![((Instance *)(self.obj[i])).index isEqualToString: @"Solid"]){
            [((Instance *)(self.obj[i])) collisionWithInstance: self.player];
            for (int j = 0; j < self.obj.count; j++){
                if (i != j){
                    [((Instance*)(self.obj[i])) collisionWithInstance: ((Instance *)(self.obj[j]))];
                }
            }
        }
    }
    [self.player finishUpdate];
    for (int i = 0; i < self.obj.count; i++){
        [((Instance *)self.obj[i]) finishUpdate];
    }
    [self changeViewXandYWithInstance: self.player];
    //Card Conditions
    CPU *cpu;
    for (int i = 0; i < self.obj.count; i++){
        if ([((Instance *)self.obj[i]).index isEqualToString: @"CPU"]){
            cpu =((CPU *)self.obj[i]);
        }
    }
    if (!cpu.protect){
        if (self.player.beingFollowed == 2){
            self.card = cpu.cardOne;
            self.cardDisplayTimer = 120;
            self.player.beingFollowed = 0;
        }
        if (self.player.guardGuess > 0){
            if (cpu.cardOne == self.player.guardGuess){
                self.winner = 1;
                self.winnerTime = 240;
            }
        }
        if (self.player.beingFollowed == 3){
            if (cpu.cardOne > self.player.cardOne){
                self.winner = 2;
                self.winnerTime = 240;
            }
            else if (cpu.cardOne < self.player.cardOne){
                self.winner = 1;
                self.winnerTime = 240;
            }
            self.player.beingFollowed = 0;
        }
        if (self.player.beingFollowed == 5){
            if (cpu.cardOne == 8){
                self.winner = 1;
                self.winnerTime = 240;
            }
            cpu.cardOne = 0;
            for (int i = 0; i < self.obj.count; i++){
                if ([((Instance *)self.obj[i]).index isEqualToString: @"Cards"]){
                    [((Cards *)self.obj[i]) drawCardForPlayer:cpu playerNum:2];
                }
            }
            self.player.beingFollowed = 0;
        }
        if (self.player.beingFollowed == 6){
            self.player.cardOne += cpu.cardOne;
            cpu.cardOne = self.player.cardOne-cpu.cardOne;
            self.player.cardOne = self.player.cardOne-cpu.cardOne;
            self.player.beingFollowed = 0;
        }
    }
    else{
       if (self.player.beingFollowed == 5){
           if (self.player.cardOne == 8){
               self.winner = 2;
               self.winnerTime = 240;
           }
           for (int i = 0; i < self.obj.count; i++){
               if ([((Instance *)self.obj[i]).index isEqualToString: @"Cards"]){
                   [((Cards *)self.obj[i]) drawCardForPlayer:self.player playerNum:1];
               }
           }
           self.player.beingFollowed = 0;
      }
    }
    if (!self.player.protect){
        if (cpu.beingFollowed == 2){
            cpu.saw = self.player.cardOne;
            cpu.beingFollowed = 0;
        }
        if (cpu.guardGuess > 0){
            if (self.player.cardOne == cpu.guardGuess){
                self.winner = 2;
                self.winnerTime = 240;
            }
        }
        if (cpu.beingFollowed == 3){
            if (cpu.cardOne > self.player.cardOne){
                self.winner = 2;
                self.winnerTime = 240;
            }
            else if (cpu.cardOne < self.player.cardOne){
                self.winner = 1;
                self.winnerTime = 240;
            }
            cpu.beingFollowed = 0;
        }
        if (cpu.beingFollowed == 5){
            if (self.player.cardOne == 8){
                self.winner = 2;
                self.winnerTime = 240;
            }
            self.player.cardOne = 0;
            for (int i = 0; i < self.obj.count; i++){
                if ([((Instance *)self.obj[i]).index isEqualToString: @"Cards"]){
                    [((Cards *)self.obj[i]) drawCardForPlayer:self.player playerNum:1];
                }
            }
            cpu.beingFollowed = 0;
        }
        if (cpu.beingFollowed == 6){
            self.player.cardOne += cpu.cardOne;
            cpu.cardOne = self.player.cardOne-cpu.cardOne;
            self.player.cardOne = self.player.cardOne-cpu.cardOne;
            cpu.beingFollowed = 0;
        }
 
    }
    if (self.player.beingFollowed == 8){
        self.winner = 2;
        self.winnerTime = 240;
        self.player.beingFollowed = 0;
    }
    if (cpu.beingFollowed == 8){
        self.winner = 1;
        self.winnerTime = 240;
        cpu.beingFollowed = 0;
        self.turn = 1;
    }
    if (self.player.cardTwo > 0){
        self.turn = 1;
    }
    else if (self.player.cardTwo == 0 && self.turn == 1 && self.player.beingFollowed == 0){
        self.turn = 2;
        if (cpu.protect){
            cpu.protect = false;
        }
    }
    else if (self.turn == 2 && cpu.cardTwo > 0){
        self.turn = 3;
    }
    else if (cpu.cardTwo == 0 && self.turn == 3 && cpu.guard == 0){
        self.turn = 0;
        if (self.player.protect){
            self.player.protect = false;
        }
    }
    if (self.player.protect && !cpu.protect){
        self.protect = 1;
    }
    else if (!self.player.protect && cpu.protect){
        self.protect = 2;
    }
    else if (self.player.protect && cpu.protect){
        self.protect = 3;
    }
    else{
        self.protect = 0;
    }
    for (int i = 0; i < self.obj.count; i++){
        if ([((Instance *)self.obj[i]).index isEqualToString: @"Cards"]){
            ((Cards *)self.obj[i]).turn = self.turn;
            if (((Cards *)self.obj[i]).compare){
                self.winner = [((Cards *)self.obj[i]) victoryWithPlayer:self.player P2:cpu];
                self.winnerTime = 240;
            }
        }
    }
    if (self.winnerTime > 0){
        for (int i = 0; i < self.obj.count; i++){
            if ([((Instance *)self.obj[i]).index isEqualToString: @"Cards"]){
                [(Cards *)self.obj[i] reset];
            }
        }
        self.player.cardOne = 0;
        self.player.cardTwo = 0;
        cpu.cardOne = 0;
        cpu.cardTwo = 0;
        self.winnerTime--;
        if (self.winnerTime == 0){
            self.winner = 0;
        }
    }
    cpu.turn = self.turn;
}

-(NSArray *)buildRoom: (NSArray *)room{
    NSMutableArray *r  = [[NSMutableArray alloc] init];
    for (int y = 0; y < room.count; y++){
        NSString *row = (NSString *)(room[y]);
        for (int x = 0; x < row.length; x++){
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"S"]){
                Solid *s = [[Solid alloc] initWithX: x y:y];
                [r addObject: s];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"P"]){
                self.player = [[Player alloc] initWithX: x y:y];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"1"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:1];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"2"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:2];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"3"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:3];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"4"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:4];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"5"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:5];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"6"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:6];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"7"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:7];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"8"]){
                NPC *n = [[NPC alloc] initWithX: x y:y num:8];
                [r addObject: n];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"Q"]){
                Starter *s = [[Starter alloc] initWithX: x y:y];
                [r addObject: s];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"C"]){
                Cards *c = [[Cards alloc] initWithX: x y:y];
                [r insertObject: c atIndex: 0];
            }
            if ([[[row substringFromIndex:x] substringToIndex: 1] isEqualToString: @"U"]){
                CPU *u = [[CPU alloc] initWithX: x y:y];
                [r addObject: u];
            }
        }
    }
    return (NSArray *)r;
}

-(NSArray *)draw{
    NSMutableArray *R = [[NSMutableArray alloc] init];
    if (self.room == 1){
        for (int i = 0; i < self.obj.count; i++){
            [R addObject: [((Instance *)(self.obj[i])) drawWithViewX: self.viewX viewY: self.viewY]];
        }
        [R addObject: [self.player drawWithViewX:self.viewX viewY:self.viewY]];
        if (self.player.cardOne > 0){
            [R addObject: @[[NSNumber numberWithInt: (int)(128+(self.player.cardOne-1)*((255-128)/7.0))], [NSNumber numberWithInt: (int)((self.player.cardOne-1)*(255/7.0))], [NSNumber numberWithInt: (int)((self.player.cardOne-1)*(255/7.0))], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: 16], [NSNumber numberWithFloat: 480-32], [NSNumber numberWithFloat: 32], [NSString stringWithFormat: @"%d", self.player.cardOne], @"Courier-Bold"]];
        }
        if (self.player.cardTwo > 0){
            [R addObject: @[[NSNumber numberWithInt: (int)(128+(self.player.cardTwo-1)*((255-128)/7.0))], [NSNumber numberWithInt: (int)((self.player.cardTwo-1)*(255/7.0))], [NSNumber numberWithInt: (int)((self.player.cardTwo-1)*(255/7.0))], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: 48], [NSNumber numberWithFloat: 480-32], [NSNumber numberWithFloat: 32], [NSString stringWithFormat: @"%d", self.player.cardTwo], @"Courier-Bold"]];
        }
        if (self.cardDisplayTimer > 0){
            [R addObject: @[[NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: (self.cardDisplayTimer)*((255)/120.0)], [NSNumber numberWithFloat: 320-128], [NSNumber numberWithFloat: 240-128], [NSNumber numberWithFloat: 256], [NSString stringWithFormat: @"%d", self.card], @"Courier-Bold"]];
        }
        if (self.protect > 0){
            NSString *say = [NSString stringWithFormat: @"Player %d is Protected!",self.protect];
            if (self.protect == 3){
                say = @"Both players are protected";
            }
            [R addObject: @[[NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: 320], [NSNumber numberWithFloat: 48-16], [NSNumber numberWithFloat: 32], say, @"Zapfino"]];
        }
        if (self.winner > 0){
            [R addObject: @[[NSNumber numberWithInt: (int)(arc4random()%255)], [NSNumber numberWithInt: (int)(arc4random()%255)], [NSNumber numberWithInt: (int)(arc4random()%255)], [NSNumber numberWithInt: 255], [NSNumber numberWithFloat: 320], [NSNumber numberWithFloat: 240-64], [NSNumber numberWithFloat: 64], [NSString stringWithFormat: @"Player %d wins!", self.winner], @"Helvetica"]];
        }
    }
    return (NSArray *)R;
}
@end
