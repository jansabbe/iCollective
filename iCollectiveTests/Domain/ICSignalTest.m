#import <CoreData/CoreData.h>
#import "ICSignalTest.h"
#import "ICSignal.h"
#import "ICStubCoreDataContext.h"


@interface ICSignalTest ()
@property(nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation ICSignalTest

- (void)setUp {
    self.context = [ICStubCoreDataContext inMemoryContext].context;
}

- (void)testGetBodyWithoutTags {
    ICSignal *signal = [[ICSignal alloc] initWithEntity:self.entity insertIntoManagedObjectContext:self.context];
    signal.body = @"<a href=\"he\">cool</a> <b>dit</b> is <i>tof</i>";
    STAssertEqualObjects([signal bodyAsPlainText], @"cool dit is tof", nil);
}

- (void)testGetBodyWithXmlEntitiesReplaced {
    ICSignal *signal = [[ICSignal alloc] initWithEntity:self.entity insertIntoManagedObjectContext:self.context];
    signal.body = @"Dit is tof &amp; cool. 1 &lt; 2 en 2 &gt; 1";
    STAssertEqualObjects([signal bodyAsPlainText], @"Dit is tof & cool. 1 < 2 en 2 > 1", nil);
}

- (void)testGetFuzzyTime {
    ICSignal *signal = [[ICSignal alloc] initWithEntity:self.entity insertIntoManagedObjectContext:self.context];
    signal.timestamp = [NSDate date];

    STAssertEqualObjects(@"now", [signal fuzzyTimestamp], nil);
}


- (void)testGetFuzzyTimeWithoutTimestamp {
    ICSignal *signal = [[ICSignal alloc] initWithEntity:self.entity insertIntoManagedObjectContext:self.context];

    STAssertNil([signal fuzzyTimestamp], nil);
}

- (NSEntityDescription *)entity {
    return [NSEntityDescription entityForName:@"Signal" inManagedObjectContext:self.context];
}

@end