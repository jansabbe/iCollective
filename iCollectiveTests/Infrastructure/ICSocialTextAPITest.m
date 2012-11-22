#import <CoreData/CoreData.h>
#import "ICSocialTextAPITest.h"
#import "ICSocialTextAPI.h"
#import "ICUserStub.h"
#import "ICUser.h"
#import "ICStubCoreDataContext.h"


@implementation ICSocialTextAPITest

- (void)setUp {
    self.socialTextClient = [[ICUserStub testUser] socialTextClient];
    self.coreDataContext = [ICStubCoreDataContext inMemoryContext];
}

- (void)testCanGenerateUrlForSignals {
    NSFetchRequest *fetchRequest = [self fetchRequestForEntity:@"Signal"];
    NSMutableURLRequest *urlRequest = [self.socialTextClient requestForFetchRequest:fetchRequest withContext:self.context];

    STAssertEqualObjects(urlRequest.URL.absoluteString, @"https://cegeka.socialtext.net/data/signals", nil);
}

- (void)testCanGenerateUrlForPeople {
    NSFetchRequest *fetchRequest = [self fetchRequestForEntity:@"Person"];
    NSMutableURLRequest *urlRequest = [self.socialTextClient requestForFetchRequest:fetchRequest withContext:self.context];

    STAssertEqualObjects(urlRequest.URL.absoluteString, @"https://cegeka.socialtext.net/data/people", nil);
}

- (void)testCanGenerateUrlForGroups {
    NSFetchRequest *fetchRequest = [self fetchRequestForEntity:@"Group"];
    NSMutableURLRequest *urlRequest = [self.socialTextClient requestForFetchRequest:fetchRequest withContext:self.context];

    STAssertEqualObjects(urlRequest.URL.absoluteString, @"https://cegeka.socialtext.net/data/groups", nil);
}

- (void)testCanGetIdentifierForSignal {
    id representation = [self representationFromJsonFile:@"basicSignal"];
    NSString *identifier = [self.socialTextClient resourceIdentifierForRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    STAssertEqualObjects(identifier, @"5038", nil);
}

- (void)testCanConvertBasicSignal {
    id representation = [self representationFromJsonFile:@"basicSignal"];

    NSDictionary *response = [self.socialTextClient attributesForRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    STAssertEqualObjects(response[@"body"], @"Business development at Argenta. Yesterday we discussed ...", nil);
    STAssertEqualObjects(response[@"signalId"], @"5038", nil);
    STAssertEqualObjects([response[@"timestamp"] description], @"2012-06-28 07:54:35 +0000", nil);
}

- (void)testCanConvertRelationshipsForBasicSignal {
    id representation = [self representationFromJsonFile:@"basicSignal"];

    NSDictionary *response = [self.socialTextClient representationsForRelationshipsFromRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    NSDictionary *expectedSender = @{
    @"id": @"73", @"best_full_name": @"Johan Lybaert"
    };
    NSArray *expectedLikers = @[@{
    @"id": @"7"
    }];

    STAssertEqualObjects(response[@"sender"], expectedSender, nil);
    STAssertNil(response[@"group"], nil);
    STAssertNil(response[@"inReplyToSignal"], nil);
    STAssertNil(response[@"replies"], nil);
    STAssertEqualObjects(response[@"likers"], expectedLikers, nil);
}


- (void)testCanConvertRelationshipsForSignalAsReply {
    id representation = [self representationFromJsonFile:@"signalAsReply"];

    NSDictionary *response = [self.socialTextClient representationsForRelationshipsFromRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    NSDictionary *expectedRepliedToSignal = @{
    @"signal_id" : @"5034"
    };

    STAssertEqualObjects(response[@"inReplyToSignal"], expectedRepliedToSignal, nil);
}

- (void)testCanConvertRelationshipsForSignalToGroup {
    id representation = [self representationFromJsonFile:@"signalToGroup"];

    NSDictionary *response = [self.socialTextClient representationsForRelationshipsFromRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    NSDictionary *expectedRepliedToSignal = @{
    @"group_id" : @"14"
    };

    STAssertEqualObjects(response[@"group"], expectedRepliedToSignal, nil);
}

- (void)testCanGetIdentifierForPerson {
    id representation = [self representationFromJsonFile:@"basicPerson"];
    NSString *identifier = [self.socialTextClient resourceIdentifierForRepresentation:representation ofEntity:[self entity:@"Person"] fromResponse:nil];

    STAssertEqualObjects(identifier, @"88", nil);
}

- (void)testCanGetIdentifierForGroup {
    id representation = [self representationFromJsonFile:@"group"];
    NSString *identifier = [self.socialTextClient resourceIdentifierForRepresentation:representation ofEntity:[self entity:@"Group"] fromResponse:nil];

    STAssertEqualObjects(identifier, @"30", nil);
}

- (void)testCanConvertPerson {

    id representation = [self representationFromJsonFile:@"basicPerson"];

    NSDictionary *response = [self.socialTextClient attributesForRepresentation:representation ofEntity:[self entity:@"Person"] fromResponse:nil];

    STAssertEqualObjects(response[@"username"], @"abderrazzaq.jebbar@cegeka.be", nil);
    STAssertEqualObjects(response[@"personId"], @"88", nil);
    STAssertEqualObjects(response[@"email"], @"abderrazzaq.jebbar@cegeka.be", nil);
    STAssertEqualObjects(response[@"fullName"], @"Abderrazzaq.Jebbar", nil);
}

- (void)testCanConvertGroup {
    id representation = [self representationFromJsonFile:@"group"];

    NSDictionary *response = [self.socialTextClient attributesForRepresentation:representation ofEntity:[self entity:@"Group"] fromResponse:nil];

    STAssertEqualObjects(response[@"groupId"], @"30", nil);
    STAssertEqualObjects(response[@"groupDescription"], @"Collect information on agile software engineering practices", nil);
    STAssertEqualObjects(response[@"name"], @"Agile Software Engineering", nil);
}


- (void)testCanCallGetAttributesWithMinimalSignal{

    NSDictionary *representation = @{
        @"signal_id": @"11"
    };
    NSDictionary *response = [self.socialTextClient attributesForRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    STAssertEqualObjects(response[@"signalId"], @"11", nil);
}

- (void)testCanCallGetAttributesWithMinimalPerson{
    NSDictionary *representation = @{
        @"id": @23
    };
    NSDictionary *response = [self.socialTextClient attributesForRepresentation:representation ofEntity:[self entity:@"Person"] fromResponse:nil];

    STAssertEqualObjects(response[@"personId"], @"23", nil);
}

- (void)testCanCallGetAttributesWithMinimalGroup{
    NSDictionary *representation = @{
        @"group_id": @"21"
    };
    NSDictionary *response = [self.socialTextClient attributesForRepresentation:representation ofEntity:[self entity:@"Group"] fromResponse:nil];

    STAssertEqualObjects(response[@"groupId"], @"21", nil);
}



- (void)testCanGetRelationshipsWithMinimalSignal{
    NSDictionary *representation = @{
        @"signal_id": @"11"
    };
    NSDictionary *response = [self.socialTextClient representationsForRelationshipsFromRepresentation:representation ofEntity:[self entity:@"Signal"] fromResponse:nil];

    STAssertNotNil(response, nil);
}

- (void)testCanGetRelationshipsWithMinimalPerson{
    NSDictionary *representation = @{
    @"id": @23
};
    NSDictionary *response = [self.socialTextClient representationsForRelationshipsFromRepresentation:representation ofEntity:[self entity:@"Person"] fromResponse:nil];


    STAssertNotNil(response, nil);
}

- (void)testCanGetRelationshipsWithMinimalGroup{
    NSDictionary *representation = @{
    @"group_id": @"21"
};
    NSDictionary *response = [self.socialTextClient representationsForRelationshipsFromRepresentation:representation ofEntity:[self entity:@"Group"] fromResponse:nil];

    STAssertNotNil(response, nil);
}

- (NSFetchRequest *)fetchRequestForEntity:(NSString *)entityName {
    NSEntityDescription *signalEntityDescription = [self entity:entityName];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = signalEntityDescription;
    return fetchRequest;
}

- (NSEntityDescription *)entity:(NSString *)entityName {
    return [NSEntityDescription entityForName:entityName
                       inManagedObjectContext:self.context];
}

- (id)representationFromJsonFile:(NSString *)resourceName {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:resourceName ofType:@"json"]];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
}

- (NSManagedObjectContext*) context {
    return self.coreDataContext.context;
}

@end