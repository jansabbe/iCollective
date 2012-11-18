#import "NSString+ICUtils.h"


@implementation NSString (ICUtils)
- (BOOL)contains:(NSString *)contains {
    return [self rangeOfString:contains].location != NSNotFound;
}

@end