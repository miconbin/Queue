//
//  Library.h
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "Info.h"
#import "Artist.h"
#import "Album.h"
#import "Queue.h"
#import "Song.h"

@class QueueItem;

@interface Library : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property Info *info;

- (void) syncWithMusicLibrary;

- (void) getArtists: (NSString *)artistName;

- (NSArray *) allSongs;

- (NSArray *) allAlbums;
- (NSArray *) getAlbumsWithPredicate: (NSPredicate *)predicate;

- (NSArray *) getSongsWithPredicate: (NSPredicate *)predicate;
- (NSArray *) getSongsFromAlbum: (Album *)album;
- (NSArray *) getSongsFromAlbum: (Album *)album withPredicate: (NSPredicate *)predicate;

- (Queue *)getQueue;
- (QueueItem *)createNewQueueItemWithSong: (Song *)song;
- (void)removeQueueItem: (QueueItem *)item;

- (void) save;

@end
