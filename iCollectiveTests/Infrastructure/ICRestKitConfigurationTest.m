//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICRestKitConfigurationTest.h"
#import "ICRestKitConfiguration.h"
#import "ICUserStub.h"
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#define MAX_TIMEOUT 10


@implementation ICRestKitConfigurationTest {
    UIImage *profileImage;
}

- (void)testCanConnectToSocialText {
    RKClient *client = [ICRestKitConfiguration configureRestKitWithUser:[ICUserStub testUser]];
    RKRequest *request = [client get:@"/people/jan.sabbe@cegeka.be/photo/small_photo" delegate:self];

    STAssertNotNil(request, @"Request should not be nil");

    [self waitUntilDownloaded:request];

    STAssertNotNil(profileImage, @"Profile image should have been downloaded");

}

- (void)requestWillPrepareForSend:(RKRequest *)request {
    NSLog(@"Request: %@", request);
}

- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error {
    STAssertNil(error, @"Error occured %@", error);
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    profileImage = [UIImage imageWithData:response.body];

}


- (void)waitUntilDownloaded:(RKRequest *)request {
    int timeout = MAX_TIMEOUT;
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        timeout--;
    } while ([request isLoading] && timeout > 0);

    STAssertTrue(timeout > 0, @"Timeout reached");
}

@end