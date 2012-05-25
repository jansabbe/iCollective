//
//  Signal.h
//  iCollective
//
//  Created by Jan Sabbe on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ICSignal : NSManagedObject

@property(nonatomic, strong) NSString *body;

@property(nonatomic, strong) NSString *senderName;

@property(nonatomic, strong) NSDate *timestamp;

+ (ICSignal *)signalWithBody:(NSString *)body sender:(NSString *)senderName timestamp:(NSDate *)timestamp inContext:(NSManagedObjectContext *)managedObjectContext;


@end
