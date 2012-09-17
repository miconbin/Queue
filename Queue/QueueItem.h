//
//  QueueItem.h
//  Queue
//
//  Created by biLLy on 9/17/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QueueItem, Song;

@interface QueueItem : NSManagedObject

@property (nonatomic, retain) Song *song;
@property (nonatomic, retain) QueueItem *next;
@property (nonatomic, retain) QueueItem *previous;

@end
