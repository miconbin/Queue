//
//  Song.m
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Song.h"


@implementation Song

@dynamic id;
@dynamic name;
@dynamic album;
@dynamic artist;

- (MPMediaItem *) getItem {    
    MPMediaQuery *songQuery= [MPMediaQuery songsQuery];
    
    [songQuery addFilterPredicate: [MPMediaPropertyPredicate predicateWithValue:self.id forProperty:MPMediaItemPropertyPersistentID]];
        
    if ([songQuery.items count] > 0) {
        return [songQuery.items objectAtIndex: 0];
        
    }
    
    return nil;
}

@end
