#import "SocialtextHTTPConnectionTest.h"
#import "SocialtextHttpConnection.h"

#define MAX_TIMEOUT 10


@interface SocialtextHTTPConnectionTest ()
- (void)waitUntilDownloaded:(SocialtextHttpConnection *)connection;
@end

@implementation SocialtextHTTPConnectionTest

- (void)testCanCreateSocialtextHttpConnectionWithRelativeUrl {
    void (^callback)(NSURLResponse *, NSData *, NSError *) = ^(NSURLResponse *response, NSData *data, NSError *error) {
    };
    SocialtextHttpConnection *connection = [SocialtextHttpConnection socialtextHttpConnection:@"/data/signals" andExecute:callback];

    STAssertNotNil(connection, nil);
    STAssertEqualObjects(connection.url.absoluteString, @"https://cegeka.socialtext.net/data/signals", nil);
    STAssertEquals(connection.callback, callback, nil);
}

- (void)testCanSendGetRequest {
    __block NSString *downloadedResult;
    SocialtextHttpConnection *connection = [SocialtextHttpConnection socialtextHttpConnection:@"/data/signals"
                                                                                   andExecute:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                                                       downloadedResult = [NSString stringWithUTF8String:data.bytes];
                                                                                   }];

    [connection sendGet];

    [self waitUntilDownloaded:connection];

    STAssertTrue([downloadedResult hasPrefix:@"[{"], @"Result from socialtext was [%@]", downloadedResult);
}

- (void)waitUntilDownloaded:(SocialtextHttpConnection *)connection {
    int timeout = MAX_TIMEOUT;
    while (connection.isReceiving && timeout > 0) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        timeout--;
    }
    STAssertTrue(timeout > 0, @"Timeout reached connecting to %@", connection.url.absoluteString);
}


@end