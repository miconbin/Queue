//
//  Queue.h
//  Queue
//
//  Created by biLLy on 9/17/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Library.h"
#import "QueueItem.h"

@class Library;

@interface Queue : NSObject {
    NSMutableArray *queue;
}

@property Library *library;

- (Queue *) initWithFirstItem: (QueueItem *)item;

- (void) pushSong: (Song*)song;
- (void) pushSongAsNext: (Song*)song;

- (Song *) getNextSong;
- (Song *) getSongAtIndex: (NSInteger *)index;

@end
