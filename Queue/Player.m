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

- (Player *) initWithMPController: (MPMusicPlayerController *) controller withQueue: (Queue *)_queue {
    playerController = controller;
    queue = _queue;
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                          selector: @selector(changePlayingState)
                                          name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                          object: nil];
    
    [playerController beginGeneratingPlaybackNotifications];
    
    
    return self;
}

- (void) playItem: (MPMediaItem *)item {
    //myFould = true;
    MPMediaItemCollection *collection = [MPMediaItemCollection collectionWithItems: [NSArray arrayWithObject: item]];
    
    [playerController setQueueWithItemCollection: collection];
    playerController.nowPlayingItem = item;
    playerController.repeatMode = MPMusicRepeatModeNone;
    [playerController play];
}

- (void) play {
    if([playerController playbackState] !=   MPMusicPlaybackStatePlaying) {
        [self playNext];
    }
}

- (void)playNext {
    Song *song = [queue pop];
    
    if(song != nil) {
        NSLog(@"Will play next");
        [self playItem: [song getItem]];
    }
    
}

-(void) changePlayingState {
    NSLog(@"changePlayingState");
    if(playerController.playbackState ==  MPMusicPlaybackStateStopped) {
        if(myFould) {
            NSLog(@"is mu fould; aborting");
            myFould = false;
        } else {
            [self playNext];
        }
        
    }

}
@end
