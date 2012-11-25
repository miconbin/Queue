//
//  QueueTableViewController.h
//  Queue
//
//  Created by biLLy on 11/25/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Queue.h"
#import "QueueCell.h"

@interface QueueTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)reload;
- (void)setQueue: (Queue *)_queue;

@end
