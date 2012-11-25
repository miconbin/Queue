//
//  Queue.m
//  Queue
//
//  Created by biLLy on 9/17/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Queue.h"

@implementation Queue {
    NSNotificationCenter *notifyCenter;
}

@synthesize library;


- (Queue *) initWithFirstItem: (QueueItem *)item {
    queue = [[NSMutableArray alloc] init];
    
    notifyCenter = [NSNotificationCenter defaultCenter];
    
    while(item != nil) {
        NSLog(@"next in queue is %@", item.song.name);
        
        [queue addObject: item];
        
        item = item.next;
    }
    
    [notifyCenter postNotificationName: @"queueChange" object:nil];
    
    return self;
}

- (void) pushSong: (Song *)song {
    QueueItem *item = [self.library createNewQueueItemWithSong: song];
    
    if([queue count] > 0) {
        item.previous = [queue lastObject];
    }
    
    [queue addObject: item];    
    [notifyCenter postNotificationName: @"queueChange" object:nil];
}

- (void) pushSongAsNext: (Song*)song {
    QueueItem *item = [self.library createNewQueueItemWithSong: song];
    
    QueueItem *next = [queue objectAtIndex: 0];
    
    next.previous = item;
    
    [queue insertObject: item atIndex:0];
    [notifyCenter postNotificationName: @"queueChange" object:nil];
}

- (Song *)pop {
    if(!queue.count) return nil;
    
    QueueItem *item = [queue objectAtIndex: 0];
    Song *song = item.song;
    
    [queue removeObject: item];
    [library removeQueueItem: item];
    
    [notifyCenter postNotificationName: @"queueChange" object:nil];
    [notifyCenter postNotificationName: @"songPop" object:nil];
    
    return song;
}

// Get songs
- (int)countQueue {    
    return [queue count];
}


// Events

- (void) onQueueChange: (id)object execute: (SEL)selector {
    [notifyCenter addObserver: object selector: selector name:@"queueChange" object: nil];
}

- (void) onPop: (id)object execute: (SEL)selector {
    [notifyCenter addObserver: object selector: selector name:@"songPop" object: nil];
}


@end
