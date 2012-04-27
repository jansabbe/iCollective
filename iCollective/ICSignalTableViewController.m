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
#import <RestKit/RestKit.h>

@interface ICSignalTableViewController ()

@end

@implementation ICSignalTableViewController

@synthesize signalsArray;

- (void)viewDidLoad
{
	[super viewDidLoad]; 
    RKObjectManager * manager = [ICRestKitConfiguration objectManager];
    [manager loadObjectsAtResourcePath:@"/signals" delegate:self];
    
    [self waitUntilDownloaded];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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
    static NSString *CellIdentifier = @"signal"; 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
    if (cell == nil) { 
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; 
    } 
    
    ICSimpleSignal *signal = [self.signalsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = signal.body; 
    return cell; 
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    signalsArray = objects;
}


- (void)waitUntilDownloaded {
    int timeout = 10;
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        timeout--;
    } while(signalsArray == nil && timeout >0);
    
}

@end