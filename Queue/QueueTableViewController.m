//
//  QueueTableViewController.m
//  Queue
//
//  Created by biLLy on 11/25/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "QueueTableViewController.h"

@implementation QueueTableViewController {
    Queue *queue;
}
@synthesize tableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setQueue: (Queue *)_queue
{
    queue = _queue;
    
    [tableView reloadData];
    tableView.scrollsToTop = NO;
    
    [queue onQueueChange:tableView execute:@selector(reloadData)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    
    [tableView setEditing:YES];
    int rows = [queue countQueue];
    
    CGRect frame = tableView.frame;
    frame.size.height = rows * 44;
    if(frame.size.height > 411) frame.size.height = 411;
    
    tableView.frame = frame;
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Create cell!!");
    static NSString *CellIdentifier = @"QueueCell";
    QueueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        
        cell = [[QueueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QueueCell"];
        
        [cell prepareLabels];
        
        cell.customBackground.backgroundColor = [UIColor whiteColor];
        CGRect frame = cell.frame;
        frame.size.height = 44;
        cell.frame = frame;
        
    }
    
    Song *song = [queue getSongAtIndex: indexPath.row];
    
    [cell updateLabelsWithIndexPath: indexPath titled: song.name ofArtist: song.artist.name rated: 5 selected: YES];
    
    return cell;
}

- (void)reload {
    [tableView reloadData];
}

// Reorder
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	Grip customization code goes in here...
	for(UIView* view in cell.subviews)
	{
		if([[[view class] description] isEqualToString:@"UITableViewCellReorderControl"])
		{
			UIView* resizedGripView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(view.frame), CGRectGetMaxY(view.frame))];
			[resizedGripView addSubview:view];
			[cell addSubview:resizedGripView];
            
			CGSize sizeDifference = CGSizeMake(resizedGripView.frame.size.width - view.frame.size.width, resizedGripView.frame.size.height - view.frame.size.height);
			CGSize transformRatio = CGSizeMake(resizedGripView.frame.size.width / view.frame.size.width, resizedGripView.frame.size.height / view.frame.size.height);
            
			//	Original transform
			CGAffineTransform transform = CGAffineTransformIdentity;
            
			//	Scale custom view so grip will fill entire cell
			transform = CGAffineTransformScale(transform, transformRatio.width, transformRatio.height);
            
			//	Move custom view so the grip's top left aligns with the cell's top left
			transform = CGAffineTransformTranslate(transform, -sizeDifference.width / 2.0, -sizeDifference.height / 2.0);
            
			[resizedGripView setTransform:transform];
            
			for(UIImageView* cellGrip in view.subviews)
			{
				if([cellGrip isKindOfClass:[UIImageView class]])
					[cellGrip setImage:nil];
			}
		}
	}
}


- (BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	[queue moveFrom: sourceIndexPath.row to:destinationIndexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

@end
