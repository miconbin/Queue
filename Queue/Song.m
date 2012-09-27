//
//  Song.m
//  Queue
//
//  Created by biLLy on 9/17/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Song.h"
#import "Album.h"
#import "Artist.h"
#import "Queue.h"


@implementation Song

@dynamic id;
@dynamic name;
@dynamic queue_pos;
@dynamic album;
@dynamic artist;
@dynamic queue;


- (MPMediaItem *) getItem {
    MPMediaQuery *songQuery= [MPMediaQuery songsQuery];
    
    [songQuery addFilterPredicate: [MPMediaPropertyPredicate predicateWithValue:self.id forProperty:MPMediaItemPropertyPersistentID]];
    
    if ([songQuery.items count] > 0) {
        return [songQuery.items objectAtIndex: 0];
        
    }
    
    return nil;
}

@end
