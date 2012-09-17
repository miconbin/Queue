//
//  Artist.m
//  Queue
//
//  Created by biLLy on 9/9/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "Artist.h"


@implementation Artist

@dynamic id;
@dynamic name;

- (void) initWithName: (NSString *)artistName {
    self.name = artistName;
}

@end
