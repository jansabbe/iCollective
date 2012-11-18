//
//  ICViewController.h
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICLoginViewController.h"

@class ICSignal;
@class ICGroup;

@interface ICSignalTableViewController : UITableViewController <ICLoginViewControllerDelegate>

@property(nonatomic, strong) ICSignal *signal;

@property(nonatomic, strong) ICGroup *group;
@end