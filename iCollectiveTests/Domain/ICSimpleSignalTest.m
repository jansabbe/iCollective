#import "ICSimpleSignalTest.h"
#import "ICSimpleSignal.h"


@implementation ICSimpleSignalTest

- (void)testGetPhotoUrl {
    ICSimpleSignal *signal = [[ICSimpleSignal alloc] init];
    signal.userId = @"89";
    STAssertEqualObjects(signal.senderPhotoUrl, @"/people/89/photo/small_photo", nil);
}

- (void)testGetBodyWithoutTags {
    ICSimpleSignal *signal = [[ICSimpleSignal alloc] init];
    signal.body= @"<a href=\"he\">cool</a> <b>dit</b> is <i>tof</i>";
    STAssertEqualObjects([signal bodyAsPlainText], @"cool dit is tof", nil);
}

@end