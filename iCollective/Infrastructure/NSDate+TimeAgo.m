#import "NSDate+TimeAgo.h"

@implementation NSDate (TimeAgo)

- (NSString *)timeAgo {
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;

    if (deltaSeconds < 5) {
        return @"now";
    } else if (deltaSeconds < 60) {
        return [NSString stringWithFormat:@"%ds", (int) deltaSeconds];
    } else if (deltaMinutes < 60) {
        return [NSString stringWithFormat:@"%dm", (int) deltaMinutes];
    } else if (deltaMinutes < (24 * 60)) {
        return [NSString stringWithFormat:@"%dh", (int) floor(deltaMinutes / 60)];
    } else if (deltaMinutes < (24 * 60 * 7)) {
        return [NSString stringWithFormat:@"%dd", (int) floor(deltaMinutes / (60 * 24))];
    } else if (deltaMinutes < (24 * 60 * 31)) {
        return [NSString stringWithFormat:@"%dw", (int) floor(deltaMinutes / (60 * 24 * 7))];
    } else if (deltaMinutes < (24 * 60 * 365.25)) {
        return [NSString stringWithFormat:@"%dm", (int) floor(deltaMinutes / (60 * 24 * 30))];
    }
    return [NSString stringWithFormat:@"%dy", (int) floor(deltaMinutes / (60 * 24 * 365))];
}

@end
