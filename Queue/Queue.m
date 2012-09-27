//
//  Queue.m
//  Queue
//
//  Created by biLLy on 9/17/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Queue.h"

@implementation Queue

@synthesize library;

- (Queue *) initWithFirstItem: (QueueItem *)item {
    queue = [[NSMutableArray alloc] init];
    
    while(item != nil) {
        NSLog(@"next in queue is %@", item.song.name);
        
        [queue addObject: item];
        
        item = item.next;
    }
    
    return self;
}

- (void) pushSong: (Song *)song {
    QueueItem *item = [self.library createNewQueueItemWithSong: song];
    
    if([queue count] > 0) {
        item.previous = [queue lastObject];
    }
    
    [queue addObject: item];       
}

- (void) pushSongAsNext: (Song*)song {
    QueueItem *item = [self.library createNewQueueItemWithSong: song];
    
    QueueItem *next = [queue objectAtIndex: 0];
    
    next.previous = item;
    
    [queue insertObject: item atIndex:0];
}

- (Song *)pop {
    if(!queue.count) return nil;
    
    QueueItem *item = [queue objectAtIndex: 0];
    Song *song = item.song;
    
    [queue removeObject: item];
    [library removeQueueItem: item];
    
    return song;
}

@end
