//
//  ViewController.m
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
    
    Queue *queue;
}

@synthesize library;
@synthesize queueTableController;
@synthesize picker;
@synthesize libraryView;
@synthesize playerView;
@synthesize queueView;
@synthesize tabBar;
@synthesize mainView;
@synthesize queueTabbarItem;

- (void)viewDidLoad
{
    picker.library = library;
    
    [picker viewDidLoad];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Queue badge
    queue = [library getQueue];
    
    [queue onQueueChange:self execute:@selector(queueChanged)];
    
    [queueTableController setQueue: queue];
    
    [self queueChanged];
    
    // loading
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.center = CGPointMake(160, 320);
    
    
    spinner.backgroundColor = [UIColor whiteColor];
    spinner.hidesWhenStopped = YES;
    spinner.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0];
    [spinner startAnimating];
    
    UILabel *label;
    
    
    [mainView addSubview: spinner];
    [mainView addSubview: label];
    
    NSLog(@"spinning...");
    
    [spinner startAnimating];
    
    [self performSelectorInBackground: @selector(sync:) withObject:spinner] ;
    
    NSLog(@"Done in didLoad");
}

- (void) sync: (UIActivityIndicatorView *)spinner {
    @autoreleasepool {
        NSLog(@"Begin sync");
        
        [self.library syncWithMusicLibrary];
        
        [spinner stopAnimating];
        
        // show tab bar
        // move to 411
        
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:0.3];
        
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        CGRect frame = tabBar.frame;
        
        frame.origin.y = 411;
        
        tabBar.frame = frame;
        
        [UIView commitAnimations];
        NSLog(@"done sync");
        
        [picker updateTable];
        [queueTableController.tableView reloadData];
    }
}

- (void)viewDidUnload
{
    [library save];
    [self setPicker:nil];
    [self setLibraryView:nil];
    [self setPlayerView:nil];
    [self setTabBar:nil];
    [self setMainView:nil];
    [self setQueueTableController:nil];
    [self setQueueView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return false;
}

// TABBAR
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"Select item of id %d", item.tag);
    
    
    currentView.hidden = YES;
    
    
    if(item.tag == 0) { // player
        
        currentView = playerView;
    }
    
    if(item.tag == 1) { // queue
        currentView = queueView;
    }
    
    if(item.tag == 2) { // library
        currentView = libraryView;
    }
    
    currentView.hidden = NO;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
	if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        cell.selectionStyle =  UITableViewCellSelectionStyleBlue;
        cell.textLabel.font = [cell.textLabel.font fontWithSize: 16];
        cell.textLabel.text = @"test";
        
    }
    
    return cell;
}

- (void)queueChanged {
    int count = [queue countQueue];
    
    
    if(count == 0) 
        queueTabbarItem.badgeValue = nil;
        
    else
        queueTabbarItem.badgeValue = [NSString stringWithFormat:@"%i", count];
}


@end
