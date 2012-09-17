//
//  AppDelegate.h
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Player.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Library *library;
@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) ViewController *viewController;

@end
