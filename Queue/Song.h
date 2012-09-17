//
//  Song.h
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MediaPlayer/MediaPlayer.h>


@interface Song : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *album;
@property (nonatomic, retain) NSManagedObject *artist;

- (MPMediaItem *) getItem;

@end
