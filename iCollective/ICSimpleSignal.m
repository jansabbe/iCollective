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
@synthesize userId = _userId;


- (NSString *)senderPhotoUrl {
    return [NSString stringWithFormat:@"/people/%@/photo/small_photo", self.userId];
}

- (NSString *)bodyAsPlainText {
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"<.+?>"
                                                                                options:0
                                                                                  error:NULL];

    return [expression stringByReplacingMatchesInString:self.body
                                                options:0
                                                  range:NSMakeRange(0, self.body.length)
                                           withTemplate:@""];
}


- (NSString *)bodyAsHtml {
    return [NSString stringWithFormat:@"<html><head><style>* {font-family: Helvetica; font-size: 14; border:0px; padding:0px; margin:0px;}</style></head><body>%@</body></html>",
                                      self.body];
}

@end