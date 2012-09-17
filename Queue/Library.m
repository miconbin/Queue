//
//  Library.m
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Library.h"

@implementation Library

@synthesize managedObjectContext, info;

- (void)syncWithMusicLibrary {
    NSDate *lastModifiedDate = [[MPMediaLibrary defaultMediaLibrary] lastModifiedDate];
    
    NSLog(@"MediaPlayer modifed date %@", [[MPMediaLibrary defaultMediaLibrary] lastModifiedDate]);
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Info"
                                   inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] == 0) {
        NSLog(@"Info doesn't exists in db; creating one");
        info = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Info"
                 inManagedObjectContext:managedObjectContext];
    } else {
        info = [fetchedObjects objectAtIndex: 0];
    }
    
    NSLog(@"Last update of Queue library is %@", info.last_update);
    
    
    if(info.last_update == NULL || [info.last_update earlierDate: lastModifiedDate] == info.last_update) {
        NSLog(@"Sync time!");
        
        NSArray *items = ([MPMediaQuery songsQuery]).items;
        
        
        for(MPMediaItem *item in items) {
            
            
            NSNumber *id = [item valueForProperty:  MPMediaItemPropertyPersistentID];
            
            NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription* entity = [NSEntityDescription entityForName:@"Song" inManagedObjectContext:managedObjectContext];
                        
            [fetchRequest setEntity:entity];
            [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"id = %@", id]];
            
            NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            NSLog(@"Results with id %i", [results count]);
            
            if([results count]) continue;
            
            Song *song = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Song"
                          inManagedObjectContext: managedObjectContext];
            
            song.name = [item valueForProperty:  MPMediaItemPropertyTitle];
            
            
            song.id = id;
            
            NSLog(@"Add song: %@", song.name);
            
            
            song.artist = [self getArtist: [item valueForProperty: MPMediaItemPropertyArtist]];
            
            Artist *albumArtist = [self getArtist: [item valueForProperty: MPMediaItemPropertyAlbumArtist]];
            
            song.album = [self getAlbum: [item valueForProperty: MPMediaItemPropertyAlbumTitle] ofArtist: albumArtist];
            
        }
        
        info.last_update = [NSDate date];
        
        [self save];
    }
}

- (Artist *) getArtist: (NSString *)artistName {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Artist" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"name = %@", artistName]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    Artist *artist = nil;
    
    if([results count] == 0) {
        NSLog(@"Artist does not present in db");
        
        artist = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Artist"
                  inManagedObjectContext: managedObjectContext];
        
        [artist initWithName: artistName];
    } else {
        NSLog(@"Artist already loaded, stack count is %i", [results count]);
        artist = [results objectAtIndex: 0];
    }
    
    
    return artist;
}


- (Album *) getAlbum: (NSString *)albumName ofArtist: (Artist *)artist {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"name = %@", albumName]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    Album *album = nil;
    
    if([results count] == 0) {
        NSLog(@"Album %@ does not present in db", albumName);
        
        album = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Album"
                  inManagedObjectContext: managedObjectContext];
        
        album.name = albumName;
        album.artist = artist;
        
    } else {
        NSLog(@"Album already loaded, stack count is %i", [results count]);
        album = [results objectAtIndex: 0];
    }
    
    
    return album;
}

- (NSArray *) allSongs {
    return [self getSongsWithPredicate: nil];
}


- (NSArray *) getAlbumsWithPredicate: (NSPredicate *)predicate {
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    if(predicate != nil) [fetchRequest setPredicate: predicate];
    
    return [managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (NSArray *) allAlbums {    
    return [self getAlbumsWithPredicate:nil];
}


- (NSArray *) getSongsWithPredicate: (NSPredicate *)predicate {
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Song" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    if(predicate != nil) [fetchRequest setPredicate: predicate];
    
    return [managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (NSArray *) getSongsFromAlbum: (Album *)album {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"album = %@", album];
    
    return [self getSongsWithPredicate: predicate];
}   

-(void) save {
    [managedObjectContext save:nil];
}

-(Queue *) getQueue {
    static Queue *queue = nil;
    
    if(queue == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"QueueItem"
                                                  inManagedObjectContext:managedObjectContext];
        
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"previous = nil"]];
        
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        if ([fetchedObjects count] == 0) {
            NSLog(@"There isnt any QueueItem; Queue will be empty");
        }
    
        queue = [[Queue alloc] initWithFirstItem: fetchedObjects.count ? [fetchedObjects objectAtIndex: 0] : nil];
        
        queue.library = self;
    }
    
    return queue;
}

- (QueueItem *)createNewQueueItemWithSong: (Song *)song {
    QueueItem *item =[NSEntityDescription
                        insertNewObjectForEntityForName:@"QueueItem"
                        inManagedObjectContext: managedObjectContext];
    
    item.song = song;
    
    return item;
}


@end
