//
//  ICViewController.h
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface ICSignalTableViewController : UITableViewController <RKObjectLoaderDelegate>

@property (nonatomic, retain) NSArray *signalsArray; 

@end