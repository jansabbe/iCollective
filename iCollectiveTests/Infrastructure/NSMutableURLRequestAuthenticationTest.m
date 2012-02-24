//
//  Created by jansabbe on 24/02/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSMutableURLRequestAuthenticationTest.h"
#import "NSMutableURLRequest+Authentication.h"


@implementation NSMutableURLRequestAuthenticationTest {

}

- (void) testCanAddAuthenticationHeaderToConnection {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request basicAuthenticationWithUsername:@"testUser" password:@"testPassword"];
    // echo -n testUser:testPassword |openssl enc -base64
    // dGVzdFVzZXI6dGVzdFBhc3N3b3Jk
    STAssertEqualObjects(@"Basic dGVzdFVzZXI6dGVzdFBhc3N3b3Jk", [request valueForHTTPHeaderField: AUTHORIZATION_HEADER], nil);
}
@end