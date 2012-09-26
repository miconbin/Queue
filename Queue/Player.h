//
//  Player.h
//  Queue
//
//  Created by biLLy on 9/13/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Library.h"

@interface Player : NSObject {
    Queue *queue;
    
    bool myFould;
}

@property Library *library;
@property Song *currentPlaying;
@property MPMusicPlayerController * playerController;

- (Player *) initWithMPController: (MPMusicPlayerController *) controller withQueue: (Queue *)queue;
- (void) playItem: (MPMediaItem *)item;
- (void) playNext;
- (void) play;

-(void) changePlayingState;

@end
