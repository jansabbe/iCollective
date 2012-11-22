//
//  ICViewController.m
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalTableViewController.h"
#import "ICSignal.h"
#import "ICUser.h"
#import "ICSignalCell.h"

@interface ICSignalTableViewController ()
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ICSignalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ICUser currentUser] ifUserCanLogin:^{
        [self configureFetchedResultsController];
    }                  ifUserCannotLogin:^{
        ICLoginViewController *controller = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }];
}

- (void)configureFetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"signalId" ascending:NO]];
    fetchRequest.fetchLimit = 50;
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[(id) [[UIApplication sharedApplication] delegate] managedObjectContext]
                                                                          sectionNameKeyPath:nil cacheName:@"iCollectiveSignals"];
    self.fetchedResultsController.delegate = self;
    [self refetchData];
}

- (void)refetchData {
    [self.fetchedResultsController performFetch:nil];
}


- (void)loginViewControllerDidCorrectlyLogin:(ICLoginViewController *)controller {
    [self configureFetchedResultsController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)heightForSignal:(ICSignal *)signal {
    CGFloat heightOfBody = [signal.bodyAsPlainText sizeWithFont:[UIFont systemFontOfSize:14.0f]
                                              constrainedToSize:CGSizeMake(241.0f, CGFLOAT_MAX)
                                                  lineBreakMode:NSLineBreakByWordWrapping].height;
    return 28.0 + heightOfBody + 9.0;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"signal";

    ICSignalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    ICSignal *signal = (ICSignal *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.signal = signal;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForSignal:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}


@end