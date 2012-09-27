//
//  ListCell.m
//  Queue
//
//  Created by temp on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "PickerCell.h"

@implementation PickerCell

@synthesize startPoint, lastMovePoint, touchMoved, imageView, imageViewLight;

@synthesize titleLabel, artistLabel, labelsWidth, titleLabelHighlihted, artistLabelHighlihted, starsFilledHighlighted, starsFilled, detailsLabel, detailsLabelHighlihted; // TODO: clean it!

@synthesize delegateView, delegateIndexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

/////////////////////////

@synthesize speakerView;

- (void)prepareLabels { // TODO: clean

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 250, 14)];
    titleLabelHighlihted =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 250, 14)];
    titleLabelHighlihted.alpha = 0;
    titleLabelHighlihted.textColor = [UIColor whiteColor];
    
    titleLabel.font = titleLabelHighlihted.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 14.0];
    
    artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 300, 12)];
    artistLabelHighlihted = [[UILabel alloc] initWithFrame:artistLabel.frame];
    artistLabelHighlihted.textColor = [UIColor colorWithRed:158 green:195 blue:223 alpha:0.6];
    
    
    artistLabel.font = artistLabelHighlihted.font = [UIFont fontWithName:@"HelveticaNeue" size: 12.0];
    artistLabel.textColor = [UIColor colorWithHue: 0 saturation:0 brightness:0.6 alpha:1];
    
    labelsWidth = 300;
    
    
    
    starsFilled = [[UILabel alloc] initWithFrame:CGRectMake(10, 21.5, 100, 18)];
    starsFilled.font = [UIFont fontWithName:@"Helvetica" size: 13.0];
    starsFilled.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    starsFilled.text = @"★★★★☆";
    
    
    starsFilledHighlighted = [[UILabel alloc] initWithFrame:CGRectMake(10, 23, 100, 18)];
    starsFilledHighlighted.font = [UIFont fontWithName:@"Helvetica" size: 13.0];
    starsFilledHighlighted.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    starsFilledHighlighted.alpha = 0;
    
    [self.contentView addSubview: starsFilled];
    [self.contentView addSubview: starsFilledHighlighted];
    
    
    detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 24, 200, 14)];
    detailsLabel.font  = [UIFont fontWithName:@"Helvetica" size: 10.0];
    detailsLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    detailsLabel.text = @"195 plays | 60% bored";
    
    detailsLabelHighlihted = [[UILabel alloc] initWithFrame:detailsLabel.frame];
    detailsLabelHighlihted.textColor = [UIColor colorWithRed:152 green:152 blue:223 alpha:1];
    detailsLabelHighlihted.alpha = 0;
    detailsLabelHighlihted.font = [UIFont fontWithName:@"Helvetica" size: 10.0];
    
   // ALog(@"Background %@", detailsLabelHighlihted.backgroundColor);
    
    detailsLabelHighlihted.backgroundColor = [UIColor clearColor]; // TODO: repeat!
    
    [self.contentView addSubview: detailsLabel];
    [self.contentView addSubview: detailsLabelHighlihted];
    
    [self.contentView addSubview: titleLabelHighlihted];
    [self.contentView addSubview: titleLabel];
    
    [self.contentView addSubview: artistLabelHighlihted];
    [self.contentView addSubview: artistLabel];
    
    artistLabelHighlihted.alpha = 0;
    titleLabelHighlihted.alpha = 0;
    imageViewLight.alpha = 0;
    starsFilledHighlighted.alpha = 0;
    detailsLabelHighlihted.alpha = 0;
    
    
}


- (void)updateLabelsWithIndexPath: (NSIndexPath *)indexPath titled: (NSString *)title ofArtist:(NSString *)artist rated: (int) stars selected: (int) selected{ // TODO: change name to something like :reuse:
    
    delegateIndexPath = indexPath;
    titleLabel.text = title;
    artistLabel.text = artist;
    
    //CGFloat titleWidth = ([[titleLabel text] sizeWithFont:[titleLabel font] forWidth: 250 lineBreakMode:UILineBreakModeTailTruncation]).width;
    CGFloat titleWidth = ([[titleLabel text] sizeWithFont:[titleLabel font]]).width;
    CGFloat artistWidth = ([[titleLabel text] sizeWithFont:[artistLabel font]]).width;
    
    ///if(titleWidth.width>250) titleWidth.width = 200;
    
    if(artistWidth + titleWidth > labelsWidth) {
        artistWidth = ([[artistLabel text] sizeWithFont:[artistLabel font] forWidth: 100 lineBreakMode:UILineBreakModeTailTruncation]).width;
        titleWidth = ([[titleLabel text] sizeWithFont:[titleLabel font] forWidth: labelsWidth - artistWidth lineBreakMode:UILineBreakModeTailTruncation]).width;
        
        
        CGRect titleFrame =  titleLabel.frame;
        titleFrame.size.width = labelsWidth - artistWidth;
        titleLabel.frame = titleFrame;
    }
    
    CGRect artistFrame =  artistLabel.frame;
    artistFrame.origin.x = titleWidth + 13;
    artistFrame.size.width = labelsWidth - titleWidth;
    artistLabel.frame = artistFrame;
    
    /*
    int i = 0;
    NSString *starsString = [[NSString alloc] init];
    
    while(++i <= 5) {
        if(i > stars) {
            starsString = [NSString stringWithFormat:@"%@%@", starsString, @"☆", nil]; 
        } else {
            starsString = [NSString stringWithFormat:@"%@%@", starsString, @"★", nil]; 
            
        }
    }
    
    starsFilled.text = starsString;
    */
    
    [self setSelection:selected withAnimations:NO];
        
}

- (void)updateLabelsWithTitle: (NSString *)title {
    titleLabel.text = title;
    
    [self setSelection:NO withAnimations:NO];
}

- (void)initImageInAccessory {
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SpeakerIconBlack.png"]];
    imageViewLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SpeakerIconLight.png"]];
    
    imageViewLight.alpha = 0;
    imageView.alpha = 0.7;
    
    CGRect frame = imageView.frame;
    frame.size.width = 10;
    frame.size.height = 10;
    
    imageView.frame = frame;
    imageViewLight.frame = frame;
    
    self.accessoryView = [[UIView alloc] initWithFrame: frame];
    
    [self.accessoryView addSubview:imageView];
    [self.accessoryView addSubview:imageViewLight];
    
    
}


////////////////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet *allTouches = [event allTouches];
	if ([allTouches count] == 1)
	{
		UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
		if ([touch tapCount] == 1)
		{
			startPoint = [touch locationInView:self];
            touchMoved = false;
            		}
	}
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet *allTouches = [event allTouches];
	if ([allTouches count] == 1)
	{
		UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
		if ([touch tapCount] == 1)
		{
			lastMovePoint = [touch locationInView:self];
            touchMoved = true;
		}
	}

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet *allTouches = [event allTouches];
	if ([allTouches count] == 1)
	{
        if(touchMoved) {
            double moveX = lastMovePoint.x - startPoint.x;
            double moveY = lastMovePoint.y - startPoint.y;
            
            
            
            if(moveX > 50) {
                [self touchSwip];
            }
        } else {
            [self touchTap];            
        }
        
	}
}

- (void)touchTap {    
    
    [self setSelection: !self.selected withAnimations: YES];
    
    if(delegateView != nil) {
        if(self.selected) [delegateView selectCell: delegateIndexPath];
        else [delegateView deselectCell: delegateIndexPath];
    }
}

- (void)setSelection: (BOOL) selected withAnimations: (BOOL)anims {
    if(self.selected == selected) return;
    
    [super setSelected: selected animated: anims];
    
    // Update highlight
    if(selected) {
        titleLabelHighlihted.frame = titleLabel.frame;
        titleLabelHighlihted.text = titleLabel.text;
        
        artistLabelHighlihted.frame = artistLabel.frame;
        artistLabelHighlihted.text = artistLabel.text;
        
        starsFilledHighlighted.text = starsFilled.text; //@"★★★★☆"
        
        detailsLabelHighlihted.text = detailsLabel.text;
    }
    
    if(anims) {
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:self.selected?0.4:0.3];
        
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    }
    
    artistLabelHighlihted.alpha = self.selected;
    titleLabelHighlihted.alpha = self.selected;
    imageViewLight.alpha = self.selected;
    starsFilledHighlighted.alpha = self.selected;
    detailsLabelHighlihted.alpha = self.selected;
    
    imageView.alpha = !self.selected;
    titleLabel.alpha = !self.selected;
    artistLabel.alpha = !self.selected;
    starsFilled.alpha = !self.selected;
    detailsLabel.alpha = !self.selected;
    
    if(anims) [UIView commitAnimations];
    
}

- (void)touchSwip {
    
    [delegateView swipeCell: delegateIndexPath onCell: self];
}
@end
