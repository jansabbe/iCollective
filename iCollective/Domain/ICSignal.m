//
//  Signal.m
//  iCollective
//
//  Created by Jan Sabbe on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignal.h"

@implementation ICSignal
@dynamic body;
@dynamic senderName;
@dynamic timestamp;


+ (ICSignal *)signalWithBody:(NSString *)body sender:(NSString *)senderName timestamp:(NSDate *)timestamp inContext:(NSManagedObjectContext *)managedObjectContext {
    ICSignal *signal = [NSEntityDescription insertNewObjectForEntityForName:@"Signal" inManagedObjectContext:managedObjectContext];
    signal.body = body;
    signal.senderName = senderName;
    signal.timestamp = timestamp;
    return signal;
}

@end
