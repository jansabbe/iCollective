//
//  Signal.h
//  iCollective
//
//  Created by Jan Sabbe on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ICPerson.h"
#import "ICGroup.h"

@interface ICSignal : NSManagedObject

@property(nonatomic, strong) NSString *signalId;
@property(nonatomic, copy) NSString *body;
@property(nonatomic, strong) NSDate *timestamp;

@property(nonatomic) ICGroup* group;
@property(nonatomic) ICSignal* inReplyToSignal;
@property(nonatomic) ICPerson* sender;
@property(nonatomic) NSSet* likers;
@property(nonatomic) NSSet* replies;

+ (ICSignal *)signalInContext:(NSManagedObjectContext *)managedObjectContext;

- (NSString *)bodyAsPlainText;

- (NSString *)fuzzyTimestamp;

@end
