//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICRestKitConfiguration.h"
#import "ICSimpleSignal.h"
#import "ICSimplePerson.h"
#import "ICUser.h"
#import <RestKit/RestKit.h>


@implementation ICRestKitConfiguration {

}

+ (RKClient *)configureRestKitWithUser:(ICUser *)user; {
    [RKClient clientWithBaseURLString:baseurl];
    [[RKClient sharedClient] setAuthenticationType:RKRequestAuthenticationTypeHTTPBasic];
    [[RKClient sharedClient] setUsername:user.userName];
    [[RKClient sharedClient] setPassword:user.password];
    [[[RKClient sharedClient] requestQueue] setShowsNetworkActivityIndicatorWhenBusy:YES];
    return [RKClient sharedClient];

}

+ (RKObjectManager *)objectManager {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:baseurl];
    [objectManager setClient:[RKClient sharedClient]];

    [objectManager setSerializationMIMEType:RKMIMETypeJSON];
    [objectManager setAcceptMIMEType:RKMIMETypeJSON];

    RKObjectMapping *signalMapping = [RKObjectMapping mappingForClass:[ICSimpleSignal class]];
    [signalMapping mapKeyPath:@"body" toAttribute:@"body"];
    [signalMapping mapKeyPath:@"best_full_name" toAttribute:@"senderName"];
    [signalMapping mapKeyPath:@"at" toAttribute:@"timestamp"];
    [signalMapping mapKeyPath:@"user_id" toAttribute:@"userId"];

    [[objectManager mappingProvider] setObjectMapping:signalMapping forResourcePathPattern:@"/signals"];

    RKObjectMapping *personMapping = [RKObjectMapping mappingForClass:[ICSimplePerson class]];
    [personMapping mapKeyPath:@"best_full_name" toAttribute:@"fullName"];
    [personMapping mapKeyPath:@"username" toAttribute:@"username"];

    [[objectManager mappingProvider] setObjectMapping:personMapping forResourcePathPattern:@"/people"];

    return objectManager;
}
@end