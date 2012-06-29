#import "ICRestKitMappingConfigurationTest.h"
#import "ICRestKitConfiguration.h"
#import "ICSimplePerson.h"
#import "ICSimpleSignal.h"
#import <RestKit/Testing.h>


@implementation ICRestKitMappingConfigurationTest

- (void)setUp {
    NSBundle *testTargetBundle = [NSBundle bundleWithIdentifier:@"be.cegeka.iCollectiveTests"];
    [RKTestFixture setFixtureBundle:testTargetBundle];
}

- (void)testCanMapPerson {
    ICSimplePerson *person = [self parsePerson:@"basicPerson.json"];

    STAssertEqualObjects(@"Abderrazzaq.Jebbar", person.fullName, nil);
    STAssertEqualObjects(@"abderrazzaq.jebbar@cegeka.be", person.email, nil);
    STAssertEqualObjects([NSNumber numberWithInt:88], person.id, nil);
    STAssertEqualObjects(@"abderrazzaq.jebbar@cegeka.be", person.username, nil);
}


- (void)testCanMapPersonWithPhoneNumber {
    ICSimplePerson *person = [self parsePerson:@"personWithPhonenumber.json"];

    STAssertEqualObjects(@"8881.112.22", person.homePhone, nil);
    STAssertEqualObjects(@"0494/16.10.56", person.mobilePhone, nil);
    STAssertEqualObjects(@"983829282", person.workPhone, nil);
}

- (void)testCanMapPersonWithTwitter {
    ICSimplePerson *person = [self parsePerson:@"personWithTwitter.json"];

    STAssertEqualObjects(@"janvr68", person.twitter, nil);
}

- (void)testCanMapPersonWithHomepage {
    ICSimplePerson *person = [self parsePerson:@"personWithHomepage.json"];

    STAssertEqualObjects(@"http://www.janvandenbussche.be", person.personalHomepage, nil);
}


- (void)testCanMapSignal {
    ICSimpleSignal *signal = [self parseSignal:@"basicSignal.json"];

    STAssertEqualObjects(@"Business development at Argenta. Yesterday we discussed ...", signal.body, nil);
    STAssertEqualObjects([NSArray arrayWithObject:@"7"], signal.personIdsLikingThis, nil);
    STAssertEqualObjects([NSNumber numberWithInt:73], signal.senderId, nil);
    STAssertEqualObjects(@"Johan Lybaert", signal.senderName, nil);
    STAssertEqualObjects([NSNumber numberWithInt:5038], signal.signalId, nil);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *actualDateComponents = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                                             fromDate:signal.timestamp];
    STAssertEquals(2012, actualDateComponents.year, nil);
    STAssertEquals(6, actualDateComponents.month, nil);
    STAssertEquals(28, actualDateComponents.day, nil);
    STAssertEquals(7, actualDateComponents.hour, nil);
    STAssertEquals(54, actualDateComponents.minute, nil);
    STAssertEquals(35, actualDateComponents.second, nil);
}

- (void)testCanMapSignalPostedToGroup {
    ICSimpleSignal *signal = [self parseSignal:@"signalToGroup.json"];

    STAssertEqualObjects([NSArray arrayWithObject:@"14"], signal.groupIdsPostedTo, nil);
}

- (void)testCanMapSignalPostedAsReplyToOtherSignal {
    ICSimpleSignal *signal = [self parseSignal:@"signalAsReply.json"];

    STAssertEqualObjects([NSNumber numberWithInt:5034], signal.inReplyToSignalId, nil);
}

- (ICSimplePerson *)parsePerson:(NSString *)jsonString {
    id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:jsonString];
    RKMappingTest *test = [RKMappingTest testForMapping:[ICRestKitConfiguration personMapping] object:parsedJSON];
    [test performMapping];
    return [test destinationObject];
}

- (ICSimpleSignal *)parseSignal:(NSString *)jsonString {
    id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:jsonString];
    RKMappingTest *test = [RKMappingTest testForMapping:[ICRestKitConfiguration signalMapping] object:parsedJSON];
    [test performMapping];
    return [test destinationObject];
}

@end