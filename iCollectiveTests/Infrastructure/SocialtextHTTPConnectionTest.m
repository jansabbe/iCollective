#import "SocialtextHTTPConnectionTest.h"
#import "SocialtextHttpConnection.h"

#define MAX_TIMEOUT 10
#define TODO_USERNAME @"DUMMY" //TODO change before committing
#define TODO_PASSWORD @"DUMMY" //TODO change before committing


@interface SocialtextHTTPConnectionTest ()
- (void)waitUntilDownloaded:(SocialtextHttpConnection *)connection;

- (void (^)(NSURLResponse *, NSData *, NSError *))createDummyCallback;
@end

@implementation SocialtextHTTPConnectionTest

- (void)testCanCreateSocialtextHttpConnectionWithRelativeUrl {
    void (^callback)(NSURLResponse *, NSData *, NSError *) = [self createDummyCallback];
    SocialtextHttpConnection *connection = [SocialtextHttpConnection socialtextHttpConnection:@"/data/signals" username:TODO_USERNAME password:TODO_PASSWORD callback:callback];

    STAssertNotNil(connection, nil);
    STAssertEqualObjects(connection.url.absoluteString, @"https://cegeka.socialtext.net/data/signals", nil);
    STAssertEquals(connection.callback, callback, nil);
}

- (void)testCanSendGetRequest {
    __block NSString *downloadedResult;
    SocialtextHttpConnection *connection = [SocialtextHttpConnection socialtextHttpConnection:@"/data/signals" username:TODO_USERNAME password:TODO_PASSWORD callback:^(NSURLResponse *response, NSData *data, NSError *error) {
        downloadedResult = [NSString stringWithUTF8String:data.bytes];
    }];

    [connection sendGet];

    [self waitUntilDownloaded:connection];

    STAssertTrue([downloadedResult hasPrefix:@"[{"], @"Result from socialtext was [%@]", downloadedResult);
}

- (void)testWhenSendingRequestApplicationShowsNetworkIndicator {
    SocialtextHttpConnection *connection = [SocialtextHttpConnection socialtextHttpConnection:@"/data/signals" username:TODO_USERNAME password:TODO_PASSWORD callback:[self createDummyCallback]];
    [connection sendGet];
    STAssertTrue([[UIApplication sharedApplication] isNetworkActivityIndicatorVisible], @"Network indicator is visible while request busy");
    [self waitUntilDownloaded:connection];
    STAssertFalse([[UIApplication sharedApplication] isNetworkActivityIndicatorVisible], @"Network indicator is not shown when request completed");
}

- (void)waitUntilDownloaded:(SocialtextHttpConnection *)connection {
    int timeout = MAX_TIMEOUT;
    while (connection.isReceiving && timeout > 0) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        timeout--;
    }
    STAssertTrue(timeout > 0, @"Timeout reached connecting to %@", connection.url.absoluteString);
}

- (void (^)(NSURLResponse *, NSData *, NSError *))createDummyCallback {
    return ^(NSURLResponse *response, NSData *data, NSError *error) {
    };
}


@end