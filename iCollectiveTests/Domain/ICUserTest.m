#import "ICUserTest.h"
#import "ICUser.h"
#import "Network.h"
#import "ICUserStub.h"


@implementation ICUserTest {

}

- (void)testCanSetUsernameAndPassword {
    ICUser *user = [ICUser currentUser];
    [user setUsername:@"test@cegeka.be" andPassword:@"passweurd"];
    STAssertEqualObjects(@"test@cegeka.be", user.userName, nil);
    STAssertEqualObjects(@"passweurd", user.password, nil);
}

- (void)testAutomaticallyAppendsAtCegekaDotBe {
    ICUser *user = [ICUser currentUser];
    [user setUsername:@"test" andPassword:@"passweurd"];
    STAssertEqualObjects(@"test@cegeka.be", user.userName, nil);
}

- (void)testStoresUsernameAndPasswordPersistent {
    [[ICUser currentUser] setUsername:@"test@bla.be" andPassword:@"pass"];
    ICUser *reloadedUser = [ICUser currentUser];
    STAssertEqualObjects(@"test@bla.be", reloadedUser.userName, nil);
    STAssertEqualObjects(@"pass", reloadedUser.password, nil);
}

- (void)testCanAskUserIfHeCanLoginCorrectUser {
    ICUser *correctUser = [ICUserStub testUser];
    __block BOOL canLoginBlockCalled = NO;

    RKRequest *request = [correctUser configureRestKitAndRunIfUserCanLogin:^() {
        canLoginBlockCalled = YES;
    }                                                    ifUserCannotLogin:^() {
        STFail(@"should be able to login");
    }];
    [self waitUntilDownloaded:request];
    STAssertTrue(canLoginBlockCalled, @"should have called login block");
}

- (void)testCanAskUserIfHeCanLoginIncorrectPassword {
    ICUser *incorrectUser = [[ICUser alloc] initWithUsername:@"blub" andPassword:@"blab"];
    __block BOOL cannotLoginBlockCalled = NO;

    RKRequest *request = [incorrectUser configureRestKitAndRunIfUserCanLogin:^() {
        STFail(@"should not be able to login");
    }                                                      ifUserCannotLogin:^() {
        cannotLoginBlockCalled = YES;
    }];
    [self waitUntilDownloaded:request];

    STAssertTrue(cannotLoginBlockCalled, @"should have called cannot login block");
    STAssertTrue(request.isCancelled, @"should cancel request");

}


- (void)testCanAskUserIfHeCanLoginNoRequestNeededIfNoUsername {
    ICUser *incorrectUser = [[ICUser alloc] initWithUsername:nil andPassword:@"blab"];
    __block BOOL cannotLoginBlockCalled = NO;

    RKRequest *request = [incorrectUser configureRestKitAndRunIfUserCanLogin:^() {
        STFail(@"should not be able to login");
    }                                                      ifUserCannotLogin:^() {
        cannotLoginBlockCalled = YES;
    }];

    STAssertNil(request, @"should not have created request");
    STAssertTrue(cannotLoginBlockCalled, @"should have called cannot login block");
}


- (void)testCanAskUserIfHeCanLoginNoRequestNeededIfNoPassword {
    ICUser *incorrectUser = [[ICUser alloc] initWithUsername:@"username" andPassword:nil];
    __block BOOL cannotLoginBlockCalled = NO;

    RKRequest *request = [incorrectUser configureRestKitAndRunIfUserCanLogin:^() {
        STFail(@"should not be able to login");
    }                                                      ifUserCannotLogin:^() {
        cannotLoginBlockCalled = YES;
    }];

    STAssertNil(request, @"should not have created request");
    STAssertTrue(cannotLoginBlockCalled, @"should have called cannot login block");
}

- (void)waitUntilDownloaded:(RKRequest *)request {
    int timeout = 30;
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        timeout--;
    } while (request.isLoading && !request.isCancelled && timeout > 0);

    STAssertTrue(timeout > 0, @"Timeout reached");
}

@end