//
//  Created by jansabbe on 30/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreData/CoreData.h>
#import "DataModelTest.h"
#import "ICSignal.h"
#import "ICStubCoreDataContext.h"


@implementation DataModelTest

- (void)setUp {
    self.coreDataContext = [ICStubCoreDataContext inMemoryContext];
}

- (void)testCanPersistSignal {
    ICSignal *signal = [ICSignal signalInContext:self.context];
    signal.signalId = @"5";

    NSError *error;
    [self.context save:&error];

    STAssertNil(error, @"Error occured during saving: %@", error);
}


- (void)testCanLoadSignal {
    NSString *expectedBody = @"Testing";
    NSDate *expectedTimestamp = [NSDate date];

    ICSignal *signal = [ICSignal signalInContext:self.context];
    signal.signalId = @"5";
    signal.body = expectedBody;
    signal.timestamp = expectedTimestamp;
    [self.context save:NULL];

    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    STAssertNil(error, @"Error while fetching: %@", error);

    ICSignal *actualSignal = results.lastObject;
    STAssertNotNil(actualSignal, @"Fetch request should have returned atleast one result");
    STAssertEqualObjects(expectedBody, actualSignal.body, nil);
    STAssertEqualObjects(expectedTimestamp, actualSignal.timestamp, nil);
}

- (void)testCanPersistAndLoadPerson {
    ICPerson *person = [ICPerson personInContext:self.context];
    person.personId= @"88";
    person.fullName = @"hello";
    person.username = @"ok";
    [self.context save:NULL];

    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    STAssertNil(error, @"Error while fetching: %@", error);

    ICPerson *actualPerson = results.lastObject;
    STAssertNotNil(actualPerson, @"Fetch request should have returned atleast one result");
    STAssertEqualObjects(person.fullName, actualPerson.fullName, nil);
    STAssertEqualObjects(person.username, actualPerson.username, nil);
    STAssertEqualObjects(person.personId, actualPerson.personId, nil);
}

- (void)testCanPersistAndLoadGroup {
    ICGroup *signal = [ICGroup groupInContext:self.context];
    signal.name = @"hello";
    signal.groupId = @"23";
    signal.groupDescription = @"expectedTimestamp";
    [self.context save:NULL];

    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    STAssertNil(error, @"Error while fetching: %@", error);

    ICGroup* actualSignal = results.lastObject;
    STAssertNotNil(actualSignal, @"Fetch request should have returned atleast one result");
    STAssertEqualObjects(signal.name, actualSignal.name, nil);
    STAssertEqualObjects(signal.groupId, actualSignal.groupId, nil);
    STAssertEqualObjects(signal.groupDescription, actualSignal.groupDescription, nil);
}

- (NSManagedObjectContext *)context {
    return self.coreDataContext.context;
}
@end