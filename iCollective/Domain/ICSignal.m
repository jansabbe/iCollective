//
//  Signal.m
//  iCollective
//
//  Created by Jan Sabbe on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignal.h"
#import "NSDate+TimeAgo.h"
#import "RestKit.h"

@implementation ICSignal
@dynamic signalId;
@dynamic body;
@dynamic senderName;
@dynamic timestamp;
@dynamic senderId;
@dynamic inReplyToSignalId;
@dynamic groupId;
@dynamic personIdsLikingThis;

+ (ICSignal *)signalInContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Signal" inManagedObjectContext:managedObjectContext];
}

- (NSString *)senderPhotoUrl {
    return [NSString stringWithFormat:@"/people/%@/photo/small_photo", self.senderId];
}

- (NSString *)bodyAsPlainText {
    NSString *bodyInPlainText = self.body;
    NSRegularExpression *tags = [NSRegularExpression regularExpressionWithPattern:@"<.+?>"
                                                                          options:0
                                                                            error:NULL];
    bodyInPlainText = [tags stringByReplacingMatchesInString:bodyInPlainText
                                                     options:0
                                                       range:NSMakeRange(0, self.body.length)
                                                withTemplate:@""];
    bodyInPlainText = [bodyInPlainText stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    bodyInPlainText = [bodyInPlainText stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    bodyInPlainText = [bodyInPlainText stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];

    return bodyInPlainText;
}


- (NSString *)bodyAsHtml {
    return [NSString stringWithFormat:@"<html><head><style>* {font-family: Helvetica; font-size: 14; border:0px; padding:0px; margin:0px;}</style></head><body>%@</body></html>",
                                      self.body];
}

- (NSString *)fuzzyTimestamp {
    return [self.timestamp timeAgo];
}

- (BOOL)isPartOfConversation {
    return self.isReplyToOtherSignal || self.hasReplies;
}

- (BOOL)isReplyToOtherSignal {
    return ![@0 isEqualToNumber:self.inReplyToSignalId];
}

- (BOOL)hasReplies {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
    request.predicate = [NSPredicate predicateWithFormat:@"inReplyToSignalId = %@", self.signalId];
    NSUInteger nbReplies = [[NSManagedObjectContext contextForCurrentThread] countForFetchRequest:request error:NULL];
    return nbReplies > 0;
}

- (ICSignal *)signalThatStartedConversation {
    if (self.isReplyToOtherSignal) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
        request.predicate = [NSPredicate predicateWithFormat:@"signalId = %@", self.inReplyToSignalId];
        return [[[NSManagedObjectContext contextForCurrentThread] executeFetchRequest:request error:NULL] lastObject];
    }
    
    return self;
}

@end
