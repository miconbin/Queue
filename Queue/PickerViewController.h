//
//  PickerViewController.h
//  Queue
//
//  Created by biLLy on 9/9/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Library.h"
#import "PickerCell.h"
#import "Player.h"

@interface PickerViewController : UITableViewController <UISearchBarDelegate, UIScrollViewDelegate, UITableViewDataSource, PickerCellDelegate> {
    bool reloadingProcess;
    NSString *lastSearchText;
    bool searchTextChangedDuringExecute;
    
    __unsafe_unretained IBOutlet UISearchBar *searchBar;
    UIActivityIndicatorView *searchBarSpinner;
}

@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property Library *library;
@property NSArray *songs;
@property NSArray *albums;

@property NSPredicate *predicadeForSongs;


@end