//
//  ICViewController.m
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICRestKitConfiguration.h"
#import "ICSignalTableViewController.h"
#import "ICSimpleSignal.h"
#import "ICUser.h"
#import "ICSignalDetailViewController.h"
#import "ICSignalCell.h"
#import <RestKit/RestKit.h>

@interface ICSignalTableViewController ()

@end

@implementation ICSignalTableViewController

@synthesize signalsArray;

- (IBAction)loadDataFromSocialText {
    RKObjectManager *manager = [ICRestKitConfiguration objectManager];
    [manager loadObjectsAtResourcePath:@"/signals?limit=50" delegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ICUser currentUser] configureRestKitAndRunIfUserCanLogin:^void() {
        [self loadDataFromSocialText];
    } ifUserCannotLogin:^void() {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.signalsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ICSignalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signal"];
    ICSimpleSignal *signal = [self.signalsArray objectAtIndex:indexPath.row];
    cell.signal = signal;
    return cell;
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Error occurred while loading signals: %@", error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    signalsArray = objects;
    [[self tableView] reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        ICLoginViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"showSignal"]) {
        ICSignalDetailViewController *controller = segue.destinationViewController;
        ICSignalCell *signalCell = sender;
        controller.signal = signalCell.signal;
    }
}

- (void)loginViewControllerDidCorrectlyLogin:(ICLoginViewController *)controller {
    [self loadDataFromSocialText];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end