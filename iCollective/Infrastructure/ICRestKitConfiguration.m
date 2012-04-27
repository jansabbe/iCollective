//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICRestKitConfiguration.h"
#import "ICSimpleSignal.h"
#import "ICSimplePerson.h"
#import <RestKit/RestKit.h>


@implementation ICRestKitConfiguration {

}

+ (RKClient *)configureRestKit {
    [RKClient clientWithBaseURLString:baseurl];
    [[RKClient sharedClient] setAuthenticationType:RKRequestAuthenticationTypeHTTPBasic];
    [[RKClient sharedClient] setUsername:username];
    [[RKClient sharedClient] setPassword:password];
    return [RKClient sharedClient];

}

+ (RKObjectManager *)objectManager {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:baseurl];
    [objectManager setClient:[self configureRestKit]];

    [objectManager setSerializationMIMEType:RKMIMETypeJSON];
    [objectManager setAcceptMIMEType:RKMIMETypeJSON];

    RKObjectMapping *signalMapping = [RKObjectMapping mappingForClass:[ICSimpleSignal class]];
    [signalMapping mapKeyPath:@"body" toAttribute:@"body"];
    [signalMapping mapKeyPath:@"best_full_name" toAttribute:@"senderName"];
    [signalMapping mapKeyPath:@"at" toAttribute:@"timestamp"];

    [[objectManager mappingProvider] setObjectMapping:signalMapping forResourcePathPattern:@"/signals"];

    RKObjectMapping *personMapping = [RKObjectMapping mappingForClass:[ICSimplePerson class]];
    [personMapping mapKeyPath:@"best_full_name" toAttribute:@"fullName"];
    [personMapping mapKeyPath:@"username" toAttribute:@"username"];

    [[objectManager mappingProvider] setObjectMapping:personMapping forResourcePathPattern:@"/people"];

    return objectManager;
}
@end