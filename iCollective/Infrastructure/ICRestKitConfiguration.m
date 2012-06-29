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

+ (RKObjectMapping *)signalMapping {
    RKObjectMapping *signalMapping = [RKObjectMapping mappingForClass:[ICSimpleSignal class]];
    [signalMapping mapKeyPath:@"body" toAttribute:@"body"];
    [signalMapping mapKeyPath:@"best_full_name" toAttribute:@"senderName"];
    [signalMapping mapKeyPath:@"at" toAttribute:@"timestamp"];
    [signalMapping mapKeyPath:@"user_id" toAttribute:@"senderId"];
    [signalMapping mapKeyPath:@"likers" toAttribute:@"personIdsLikingThis"];
    [signalMapping mapKeyPath:@"signal_id" toAttribute:@"signalId"];
    [signalMapping mapKeyPath:@"group_ids" toAttribute:@"groupIdsPostedTo"];
    [signalMapping mapKeyPath:@"in_reply_to.signal_id" toAttribute:@"inReplyToSignalId"];
    return signalMapping;
}

+ (RKObjectMapping *)personMapping {
    RKObjectMapping *personMapping = [RKObjectMapping mappingForClass:[ICSimplePerson class]];

    [personMapping mapKeyPath:@"best_full_name" toAttribute:@"fullName"];
    [personMapping mapKeyPath:@"username" toAttribute:@"username"];
    [personMapping mapKeyPath:@"email" toAttribute:@"email"];
    [personMapping mapKeyPath:@"id" toAttribute:@"id"];
    [personMapping mapKeyPath:@"personal_url" toAttribute:@"personalHomepage"];
    [personMapping mapKeyPath:@"mobile_phone" toAttribute:@"mobilePhone"];
    [personMapping mapKeyPath:@"work_phone" toAttribute:@"workPhone"];
    [personMapping mapKeyPath:@"home_phone" toAttribute:@"homePhone"];
    [personMapping mapKeyPath:@"twitter_sn" toAttribute:@"twitter"];
    return personMapping;
}

+ (RKObjectManager *)objectManager {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:baseurl];
    [objectManager setClient:[RKClient sharedClient]];

    [objectManager setSerializationMIMEType:RKMIMETypeJSON];
    [objectManager setAcceptMIMEType:RKMIMETypeJSON];

    [[objectManager mappingProvider] setObjectMapping:[self signalMapping] forResourcePathPattern:@"/signals"];
    [[objectManager mappingProvider] setObjectMapping:[self personMapping] forResourcePathPattern:@"/people"];

    return objectManager;
}
@end