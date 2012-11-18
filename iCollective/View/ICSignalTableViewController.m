//
//  ICViewController.m
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalTableViewController.h"
#import "ICSignal.h"
#import "ICSignalDetailViewController.h"
#import "ICGroup.h"

@interface ICSignalTableViewController ()
@property(nonatomic, strong) NSFetchedResultsController *tableController;
@end

@implementation ICSignalTableViewController
@synthesize tableController;
@synthesize group = _group;


- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // [NSManagedObjectContext contextForCurrentThread]
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        ICLoginViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"showSignalDetail"]) {
        ICSignalDetailViewController *controller = segue.destinationViewController;
        controller.signal = sender;
    } else if ([segue.identifier isEqualToString:@"showSignalConversation"]) {
        ICSignal *originalSignal = sender;
        ICSignalTableViewController *controller = segue.destinationViewController;
        controller.signal = originalSignal.inReplyToSignal;
    }
}


- (void)loginViewControllerDidCorrectlyLogin:(ICLoginViewController *)controller {
    //[self configureTableController];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (CGFloat)heightForSignal:(ICSignal *)signal {
    CGFloat heightOfBody = [signal.bodyAsPlainText sizeWithFont:[UIFont systemFontOfSize:14.0f]
                                              constrainedToSize:CGSizeMake(241.0f, CGFLOAT_MAX)
                                                  lineBreakMode:NSLineBreakByWordWrapping].height;
    return 28.0 + heightOfBody + 9.0;
}

@end