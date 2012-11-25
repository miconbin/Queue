//
//  ViewController.h
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Library.h"
#import "PickerViewController.h"
#import "QueueTableViewController.h"

@interface ViewController : UIViewController <UITabBarDelegate, UITableViewDataSource> {
    UIView *currentView;
}

@property Library *library;
@property (strong, nonatomic) IBOutlet QueueTableViewController *queueTableController;
@property (strong, nonatomic) IBOutlet PickerViewController *picker;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *libraryView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *playerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *queueView;
@property (unsafe_unretained, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UITabBarItem *queueTabbarItem;


- (void)queueChanged;

@end
