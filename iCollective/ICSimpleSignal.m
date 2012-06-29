//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICSimpleSignal.h"


@implementation ICSimpleSignal
@synthesize body = _body;
@synthesize senderName = _senderName;
@synthesize timestamp = _timestamp;
@synthesize personIdsLikingThis = _personIdsLikingThis;
@synthesize senderId = _senderId;
@synthesize inReplyToSignalId = _inReplyToSignalId;
@synthesize signalId = _signalId;
@synthesize groupIdsPostedTo = _groupIdsPostedTo;


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

@end