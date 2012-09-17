//
//  Player.m
//  Queue
//
//  Created by biLLy on 9/13/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize playerController;

- (Player *) initWithMPController: (MPMusicPlayerController *) controller {
    playerController = controller;
    
    return self;
}

- (void) playItem: (MPMediaItem *)item {
    MPMediaItemCollection *collection = [MPMediaItemCollection collectionWithItems: [NSArray arrayWithObject: item]];
    
    [playerController setQueueWithItemCollection: collection];
    playerController.nowPlayingItem = item;
    playerController.repeatMode = MPMusicRepeatModeNone;
    [playerController play];

}

@end
