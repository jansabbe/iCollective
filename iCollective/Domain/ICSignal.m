//
//  Signal.m
//  iCollective
//
//  Created by Jan Sabbe on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignal.h"
#import "NSDate+TimeAgo.h"

@implementation ICSignal
@dynamic signalId;
@dynamic body;
@dynamic timestamp;
@dynamic numReplies;
@dynamic group;
@dynamic inReplyToSignal;
@dynamic sender;
@dynamic likers;
@dynamic replies;


+ (ICSignal *)signalInContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Signal" inManagedObjectContext:managedObjectContext];
}

- (NSString *)bodyAsPlainText {
    if (!self.body) {
        return nil;
    }

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

- (BOOL)isReplyToOtherSignal {
    return self.inReplyToSignal != nil;
}

- (BOOL)isPartOfConversation {
    return [self isReplyToOtherSignal] || [self hasReplies];
}

- (BOOL)hasReplies {
    return (self.replies != nil && self.replies.count > 0);
}

@end
