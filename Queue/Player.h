//
//  Player.h
//  Queue
//
//  Created by biLLy on 9/13/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Library.h"

@interface Player : NSObject

@property Library *library;
@property Song *currentPlaying;
@property MPMusicPlayerController * playerController;


- (Player *) initWithMPController: (MPMusicPlayerController *) controller;
- (void) playItem: (MPMediaItem *)item;

-(void) changePlayingState;

@end
