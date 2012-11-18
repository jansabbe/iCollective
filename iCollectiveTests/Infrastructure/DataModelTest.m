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

- (NSManagedObjectContext*) context {
    return self.coreDataContext.context;
}
@end