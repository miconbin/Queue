//
//  Artist.h
//  Queue
//
//  Created by biLLy on 9/9/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MediaPlayer/MediaPlayer.h>


@interface Artist : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;

- (void) initWithName: (NSString *)artistName;

@end
