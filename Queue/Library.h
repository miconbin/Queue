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
#import "Song.h"

@interface Library : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void) syncWithMusicLibrary;

- (void) getArtists: (NSString *)artistName;

- (NSArray *) allSongs;

- (NSArray *) allAlbums;
- (NSArray *) getAlbumsWithPredicate: (NSPredicate *)predicate;

- (NSArray *) getSongsWithPredicate: (NSPredicate *)predicate;
- (NSArray *) getSongsFromAlbum: (Album *)album;
- (NSArray *) getSongsFromAlbum: (Album *)album withPredicate: (NSPredicate *)predicate;

- (void) save;

@end
