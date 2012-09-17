//
//  Song.h
//  Queue
//
//  Created by biLLy on 9/17/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Library.h"

@class Album, Artist, Queue;

@interface Song : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * position_in_queue;
@property (nonatomic, retain) Album *album;
@property (nonatomic, retain) Artist *artist;
@property (nonatomic, retain) Queue *queue;

- (MPMediaItem *) getItem;

@end
