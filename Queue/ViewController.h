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

@interface ViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>

@property Library *library;
@property (strong, nonatomic) IBOutlet PickerViewController *picker;

@end
