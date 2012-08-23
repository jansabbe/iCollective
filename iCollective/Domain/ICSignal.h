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

@interface ICSignal : NSManagedObject

@property(nonatomic, strong) NSNumber *signalId;
@property(nonatomic, copy) NSString *body;
@property(nonatomic, copy) NSString *senderName;
@property(nonatomic, strong) NSDate *timestamp;
@property(nonatomic, strong) NSNumber *senderId;
@property(nonatomic, strong) NSNumber *inReplyToSignalId;
@property(nonatomic, strong) ICPerson *sender;
@property(nonatomic, strong) ICSignal *inReplyToSignal;

+ (ICSignal *)signalInContext:(NSManagedObjectContext *)managedObjectContext;

- (NSString *)senderPhotoUrl;

- (NSString *)bodyAsPlainText;

- (NSString *)fuzzyTimestamp;


@end
