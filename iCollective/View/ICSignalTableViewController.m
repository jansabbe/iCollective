//
//  ICViewController.m
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICRestKitConfiguration.h"
#import "ICSignalTableViewController.h"
#import "ICSignal.h"
#import "ICSignalCell.h"
#import "ICUser.h"
#import "ICSignalDetailViewController.h"
#import "ICGroup.h"
#import <RestKit/NSManagedObject+ActiveRecord.h>
#import <RestKit/RestKit.h>
#import <RestKit/UI.h>
#import "RKGHLoadingView.h"

@interface ICSignalTableViewController ()
@property(nonatomic, strong) RKFetchedResultsTableController *tableController;
@end

@implementation ICSignalTableViewController
@synthesize tableController;
@synthesize group = _group;


- (void)viewDidLoad {
    [super viewDidLoad];
    [[ICUser currentUser] configureRestKitAndRunIfUserCanLogin:^void() {
        [self configureTableController];
    }                                        ifUserCannotLogin:^void() {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }];
}

- (void)configureTableController {
    self.tableController = [[RKObjectManager sharedManager] fetchedResultsTableControllerForTableViewController:self];
    self.tableController.variableHeightRows = YES;
    self.tableController.autoRefreshFromNetwork = YES;
    self.tableController.pullToRefreshEnabled = YES;
    self.tableController.delegate = self;
    [self setupTableControllerToFetchCorrectData];

    RKGHLoadingView *loadingView = [[RKGHLoadingView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    loadingView.center = self.tableView.center;
    self.tableController.loadingView = loadingView;
    
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"ICSignalCell";
    cellMapping.reuseIdentifier = @"signal";
    cellMapping.heightOfCellForObjectAtIndexPath = ^(ICSignal *signal, NSIndexPath *indexPath) {
        return [self heightForSignal:signal];
    };

    [cellMapping mapKeyPath:@"bodyAsPlainText" toAttribute:@"signalTextLabel.text"];
    [cellMapping mapKeyPath:@"senderName" toAttribute:@"senderNameLabel.text"];
    [cellMapping mapKeyPath:@"fuzzyTimestamp" toAttribute:@"timestampLabel.text"];
    [cellMapping mapKeyPath:@"senderPhotoUrl" toAttribute:@"senderPhotoUrl"];
    cellMapping.onCellWillAppearForObjectAtIndexPath = ^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
        ICSignal *signal = object;
        ICSignalCell *signalCell = (ICSignalCell *) cell;
        signalCell.replyToImage.hidden = !signal.isPartOfConversation;
        if (signal.isReplyToOtherSignal) {
            signalCell.replyToImage.image = [UIImage imageNamed:@"transarrow"];
        } else {
            signalCell.replyToImage.image = [UIImage imageNamed:@"speechbaloon"];
        }
    };

    [self.tableController mapObjectsWithClass:[ICSignal class] toTableCellsWithMapping:cellMapping];
    [self.tableController loadTable];
}

- (void)setupTableControllerToFetchCorrectData {
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"signalId" ascending:NO];
    self.tableController.resourcePath = @"/signals?limit=200";
    if (self.group) {
        self.tableController.resourcePath = [NSString stringWithFormat:@"/signals?groups=%@&limit=200",self.group.groupId];
        self.tableController.predicate = [NSPredicate predicateWithFormat:@"groupId == %@", self.group.groupId];
    } else if (self.signal) {
        self.tableController.predicate = [NSPredicate predicateWithFormat:@"signalId == %@ or inReplyToSignalId == %@",
            self.signal.signalId, self.signal.signalId];
        descriptor = [NSSortDescriptor sortDescriptorWithKey:@"signalId" ascending:YES];
    }
    self.tableController.sortDescriptors = [NSArray arrayWithObject:descriptor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableController loadTable];
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
        controller.signal = [originalSignal signalThatStartedConversation];
    }
}


- (void)loginViewControllerDidCorrectlyLogin:(ICLoginViewController *)controller {
    [self configureTableController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableController:(RKAbstractTableController *)aTableController didSelectCell:(UITableViewCell *)cell forObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    ICSignal *signal = [self.tableController objectForRowAtIndexPath:indexPath];
    if (!self.signal && signal.isPartOfConversation) {
        [self performSegueWithIdentifier:@"showSignalConversation" sender:signal];
    } else {
        [self performSegueWithIdentifier:@"showSignalDetail" sender:signal];
    }
}


- (CGFloat)heightForSignal:(ICSignal *)signal {
    CGFloat heightOfBody = [signal.bodyAsPlainText sizeWithFont:[UIFont systemFontOfSize:14.0f]
                                              constrainedToSize:CGSizeMake(241.0f, CGFLOAT_MAX)
                                                  lineBreakMode:UILineBreakModeWordWrap].height;
    return 28.0 + heightOfBody + 9.0;
}

@end