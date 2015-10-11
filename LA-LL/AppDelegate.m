//
//  AppDelegate.m
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright (c) 2015 Chance Roberts. All rights reserved.
//

#import "AppDelegate.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
        
    return scene;
}

@end

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    GameScene *scene = [[GameScene alloc] init];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    scene.backgroundColor = [SKColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [self.skView presentScene:scene];
    self.skView.showsFPS = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
