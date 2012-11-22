#import <CoreData/CoreData.h>
#import "ICIncrementalStoreTest.h"
#import "ICStubCoreDataContext.h"
#import "ICUserStub.h"
#import "ICUser.h"
#import "AFHTTPClient.h"
#import "ICSocialTextAPI.h"
#import "ICSignal.h"


@implementation ICIncrementalStoreTest

- (void)setUp {
    static ICUser *currentUser = nil;
    static ICStubCoreDataContext *firstContext = nil;
    if (!currentUser && ! firstContext) {
        currentUser = [ICUserStub testUser];
        firstContext = [ICStubCoreDataContext socialTextContext:currentUser];
    }
    self.user = currentUser;
    self.context = firstContext;
}

- (void)testACanLoadSignals {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
    NSError *error = nil;
    [self.context.context executeFetchRequest:request error:&error];
    [[self.user.socialTextClient operationQueue] waitUntilAllOperationsAreFinished];
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    NSArray *results = [self.context.context executeFetchRequest:request error:&error];

    STAssertNil(error, @"Error while fetching: %@", error);
    STAssertNotNil(results.lastObject, @"Fetch request should have returned atleast one result");
    ICSignal *bla = results.lastObject;
    NSLog(@"%@ - %@", bla.sender.fullName, bla.sender.email);
}

- (void)testCanLoadPeople {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSError *error = nil;
    [self.context.context executeFetchRequest:request error:&error];
    [[self.user.socialTextClient operationQueue] waitUntilAllOperationsAreFinished];
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    NSArray *results = [self.context.context executeFetchRequest:request error:&error];

    STAssertNil(error, @"Error while fetching: %@", error);
    STAssertNotNil(results.lastObject, @"Fetch request should have returned atleast one result");
}


- (void)testCanLoadGroups {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    NSError *error = nil;
    [self.context.context executeFetchRequest:request error:&error];
    [[self.user.socialTextClient operationQueue] waitUntilAllOperationsAreFinished];
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    NSArray *results = [self.context.context executeFetchRequest:request error:&error];

    STAssertNil(error, @"Error while fetching: %@", error);
    STAssertNotNil(results.lastObject, @"Fetch request should have returned atleast one result");
}
@end