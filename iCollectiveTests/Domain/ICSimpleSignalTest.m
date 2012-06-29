#import "ICSimpleSignalTest.h"
#import "ICSimpleSignal.h"


@implementation ICSimpleSignalTest

- (void)testGetPhotoUrl {
    ICSimpleSignal *signal = [[ICSimpleSignal alloc] init];
    signal.senderId = [NSNumber numberWithInt:89];
    STAssertEqualObjects(signal.senderPhotoUrl, @"/people/89/photo/small_photo", nil);
}

- (void)testGetBodyWithoutTags {
    ICSimpleSignal *signal = [[ICSimpleSignal alloc] init];
    signal.body= @"<a href=\"he\">cool</a> <b>dit</b> is <i>tof</i>";
    STAssertEqualObjects([signal bodyAsPlainText], @"cool dit is tof", nil);
}

- (void)testGetBodyWithXmlEntitiesReplaced {
    ICSimpleSignal *signal = [[ICSimpleSignal alloc] init];
    signal.body= @"Dit is tof &amp; cool. 1 &lt; 2 en 2 &gt; 1";
    STAssertEqualObjects([signal bodyAsPlainText], @"Dit is tof & cool. 1 < 2 en 2 > 1", nil);
}

@end