//
//  PickerViewController.m
//  Queue
//
//  Created by biLLy on 9/9/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

@synthesize library, songs;

@synthesize predicadeForSongs;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"View did load");
    
    reloadingProcess = false;
    searchTextChangedDuringExecute = false;
    
    // Hiding search bar
    [self.tableView setContentOffset:CGPointMake(0, 44) animated:NO];
    
    [self updateTable];
    
    // Add loading spinner
    searchBarSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    searchBarSpinner.center = CGPointMake(23, 23);
    
    CGRect frame = searchBarSpinner.frame;
    
    frame.size.width = 18;
    frame.size.height = 18;
    
    [searchBarSpinner setFrame: frame];
    
    searchBarSpinner.backgroundColor = [UIColor whiteColor];
    searchBarSpinner.hidesWhenStopped = YES;
    
    [searchBar addSubview:searchBarSpinner];
    
    
    NSLog(@"Spinner added");
    
    // Set queue instance
    queue = [library getQueue];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@synthesize albums;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    return [albums count];
}

// Table view


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [[songs objectAtIndex: section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    Album *album = [albums objectAtIndex: section];
    
    return album.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
	if (cell == nil) {
        cell = [[PickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        [cell prepareLabels];
        
        cell.selectionStyle =  UITableViewCellSelectionStyleBlue;
        
        cell.delegateView = self;
    }
    
    cell.delegateIndexPath = indexPath;
    
    Song *song = [[songs objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
    
    [cell updateLabelsWithTitle: [song name]];
    //cell.textLabel.text = [[songs objectAtIndex: indexPath.row] name];
    
    return cell;
}

/// PickCellDelegate

- (void)selectCell:(NSIndexPath *)indexPath {
    NSLog(@"Select cell at index %i", indexPath.row);
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    Song *selected = [[songs objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
    
    [queue pushSong: selected];
    [library save];
    
    [delegate.player play];
    
}

- (void)deselectCell:(NSIndexPath *)indexPath {
    
}

- (void)swipeCell:(NSIndexPath *)indexPath onCell: (PickerCell *)cell {
    
}

// searchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    lastSearchText = searchText;
    
    if(reloadingProcess) {
        NSLog(@"Some search is executing now");
        searchTextChangedDuringExecute = true;
    } else {
        reloadingProcess = true;
        
        [NSThread detachNewThreadSelector:@selector(updateTable) toTarget:self withObject:nil];
        
        [searchBarSpinner startAnimating];

    }
    
    NSLog(@"RETURNED FROM searchBar:textDidChange: ");
}

- (void) updateTable {
    @autoreleasepool {
        NSString *searchText = lastSearchText == nil ? nil : [NSMutableString stringWithString:lastSearchText];
        
        
        NSPredicate *predicate = nil;
        predicadeForSongs = nil;
        
        if(searchText != nil && ![searchText isEqualToString:@""]) {
            NSLog(@"Searching songs begins with: %@", searchText);
            
            predicadeForSongs = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText];
            predicate = [NSPredicate predicateWithFormat:@"ANY songs.name BEGINSWITH[cd] %@", searchText];
            
        }
                
        albums = [library getAlbumsWithPredicate: predicate];
        
        NSLog(@"Found %i albums pass", [albums count]);
        
        NSMutableArray *songsCollection = [[NSMutableArray alloc] init];
        NSSet *filtered;

        
        for(Album *album in albums) {     
            if(predicadeForSongs != nil) filtered = [album.songs filteredSetUsingPredicate: predicadeForSongs];
            else filtered = [album songs];
            
            [songsCollection addObject: [filtered allObjects]];
        }
        
        songs = songsCollection;
        
        if(searchTextChangedDuringExecute) {
            searchTextChangedDuringExecute = false;
            
            NSLog(@"Changed text during reload");
            
            return [self updateTable];
        }
        
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
        
        NSLog(@"Finish reolading");
        NSLog(@"END THREAD");
        
        
        if(searchTextChangedDuringExecute) {
            searchTextChangedDuringExecute = false;
            
            NSLog(@"Changed text during reload");
            
            return [self updateTable];
        }
        
        [searchBarSpinner stopAnimating];

        reloadingProcess = false;
        
    }
    
}

// Hide keyboard

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [searchBar resignFirstResponder];
}


@end
