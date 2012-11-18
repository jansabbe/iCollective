#import "ICUserTest.h"
#import "ICUser.h"
#import "ICUserStub.h"
#import "ICSocialTextAPI.h"


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

    [correctUser ifUserCanLogin:^{
        canLoginBlockCalled = YES;
    }                                             ifUserCannotLogin:^{
        STFail(@"should be able to login");
    }];

    [self waitUntilNetworkFinished: correctUser];
    STAssertTrue(canLoginBlockCalled, @"should have called login block");
}

- (void)testCanAskUserIfHeCanLoginIncorrectPassword {
    ICUser *incorrectUser = [[ICUser alloc] initWithUsername:@"blub" andPassword:@"blab"];
    __block BOOL cannotLoginBlockCalled = NO;

    [incorrectUser ifUserCanLogin:^{
        STFail(@"should not be able to login");
    }                                               ifUserCannotLogin:^{
        cannotLoginBlockCalled = YES;
    }];


    [self waitUntilNetworkFinished: incorrectUser];
    STAssertTrue(cannotLoginBlockCalled, @"should have called cannot login block");
}


- (void)testCanAskUserIfHeCanLoginNoRequestNeededIfNoUsername {
    ICUser *incorrectUser = [[ICUser alloc] initWithUsername:nil andPassword:@"blab"];
    __block BOOL cannotLoginBlockCalled = NO;

    [incorrectUser ifUserCanLogin:^{
        STFail(@"should not be able to login");
    }                                               ifUserCannotLogin:^{
        cannotLoginBlockCalled = YES;
    }];

    STAssertTrue(cannotLoginBlockCalled, @"should have called cannot login block");
}


- (void)testCanAskUserIfHeCanLoginNoRequestNeededIfNoPassword {
    ICUser *incorrectUser = [[ICUser alloc] initWithUsername:@"username" andPassword:nil];
    __block BOOL cannotLoginBlockCalled = NO;

    [incorrectUser ifUserCanLogin:^{
        STFail(@"should not be able to login");
    }                                               ifUserCannotLogin:^{
        cannotLoginBlockCalled = YES;
    }];

    STAssertTrue(cannotLoginBlockCalled, @"should have called cannot login block");
}

- (void)waitUntilNetworkFinished: (ICUser *) user {
    [[user.socialTextClient operationQueue] waitUntilAllOperationsAreFinished];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

@end