//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICRestKitModelConfigurationTest.h"
#import "ICRestKitConfiguration.h"
#import "ICSimpleSignal.h"
#import "ICPerson.h"
#import "ICUserStub.h"
#import <RestKit/RestKit.h>

#define MAX_TIMEOUT 30


@implementation ICRestKitModelConfigurationTest {
    NSArray *loadedObjects;
}

- (void)setUp {
    [super setUp];
    [ICRestKitConfiguration configureRestKitWithUser:[ICUserStub testUser]];
}


- (void)testCanLoadSignalFromSocialText {
    RKObjectManager *manager = [ICRestKitConfiguration objectManager];
    [manager loadObjectsAtResourcePath:@"/signals" delegate:self];
    [self waitUntilDownloaded];

    STAssertTrue([loadedObjects count] > 0, @"Loaded objects is empty");
    STAssertEqualObjects([[loadedObjects lastObject] class], [ICSimpleSignal class], @"Expected ICSimpleSignal in list");

}

- (void)testCanLoadPeopleFromSocialText {
    RKObjectManager *manager = [ICRestKitConfiguration objectManager];
    [manager loadObjectsAtResourcePath:@"/people" delegate:self];
    [self waitUntilDownloaded];

    STAssertTrue([loadedObjects count] > 0, @"Loaded objects is empty");
    STAssertEqualObjects([[loadedObjects lastObject] class], [ICPerson class], @"Expected ICSimplePerson in list");

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    STAssertNil(error, @"Error should be nil: %@", error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    loadedObjects = objects;
}

- (void)waitUntilDownloaded {
    int timeout = MAX_TIMEOUT;
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        timeout--;
    } while (loadedObjects == nil && timeout > 0);

    STAssertTrue(timeout > 0, @"Timeout reached");
}

@end