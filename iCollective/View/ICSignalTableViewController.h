//
//  ICViewController.h
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/UI.h>
#import "ICLoginViewController.h"

@class ICSignal;

@interface ICSignalTableViewController : UITableViewController <ICLoginViewControllerDelegate, RKFetchedResultsTableControllerDelegate>

@property (nonatomic, strong) ICSignal *signal;

@end