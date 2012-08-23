//
//  Created by jansabbe on 30/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreData/CoreData.h>
#import "DataModelTest.h"
#import "ICSignal.h"


@implementation DataModelTest
@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize store = _store;
@synthesize context = _context;


- (void)setUp {
    self.model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    self.store = [self.coordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                configuration:nil URL:nil options:nil error:NULL];

    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = self.coordinator;


}


- (void)testCanPersistSignal {
    ICSignal *signal = [ICSignal signalInContext:self.context];
    signal.signalId = @5;
    
    NSError *error;
    [self.context save:&error];

    STAssertNil(error, @"Error occured during saving: %@", error);
}


- (void)testCanLoadSignal {
    NSString *expectedBody = @"Testing";
    NSString *expectedSender = @"Jonnie";
    NSDate *expectedTimestamp = [NSDate date];

    ICSignal *signal = [ICSignal signalInContext:self.context];
    signal.signalId = @5;
    signal.body = expectedBody;
    signal.senderName = expectedSender;
    signal.timestamp = expectedTimestamp;
    [self.context save:NULL];

    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    STAssertNil(error, @"Error while fetching: %@", error);

    ICSignal *actualSignal = results.lastObject;
    STAssertNotNil(actualSignal, @"Fetch request should have returned atleast one result");
    STAssertEqualObjects(expectedBody, actualSignal.body, nil);
    STAssertEqualObjects(expectedSender, actualSignal.senderName, nil);
    STAssertEqualObjects(expectedTimestamp, actualSignal.timestamp, nil);
}


@end