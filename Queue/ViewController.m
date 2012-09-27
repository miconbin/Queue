//
//  ViewController.m
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize library;
@synthesize picker;
@synthesize libraryView;
@synthesize playerView;

- (void)viewDidLoad
{
    picker.library = library;
    
    [picker viewDidLoad];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [library save];
    [self setPicker:nil];
    [self setLibraryView:nil];
    [self setPlayerView:nil];
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



@end
