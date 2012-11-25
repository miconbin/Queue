//
//  ListCell.h
//  Queue
//
//  Created by temp on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController, PickerCell;

@protocol PickerCellDelegate <NSObject>

- (void)selectCell:(NSIndexPath *)indexPath;
- (void)deselectCell:(NSIndexPath *)indexPath;
- (void)swipeCell:(NSIndexPath *)indexPath onCell: (PickerCell *)cell;
- (void)disableScroll;
- (void)enableScroll;


@end



@interface PickerCell : UITableViewCell

@property CGPoint startPoint, lastMovePoint;
@property bool touchMoved;

@property UIImageView *imageView, *imageViewLight;
@property UILabel *titleLabel, *artistLabel, *detailsLabel;
@property UIView  *speakerView, *nextSongIcon;
@property UILabel *titleLabelHighlihted, *artistLabelHighlihted, *detailsLabelHighlihted, *speakerViewHighlihted, *nextSongIconHighlihted;
@property UILabel *starsFilled, *starsFilledHighlighted;
@property CGFloat labelsWidth;
@property NSIndexPath *delegateIndexPath;
@property(nonatomic,assign) id <PickerCellDelegate> delegateView;

- (void)prepareLabels;
- (void)updateLabelsWithIndexPath: (NSIndexPath *)indexPath titled: (NSString *)title ofArtist:(NSString *)artist rated: (int) stars selected: (int) selected;
- (void)updateLabelsWithTitle: (NSString *)title;
- (void)initImageInAccessory;
- (void)setSelection: (BOOL) selected withAnimations: (BOOL)anims;

- (void)touchTap;
- (void)touchSwip;



@end
