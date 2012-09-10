//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICRestKitConfiguration.h"
#import "ICSignal.h"
#import "ICPerson.h"
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

+ (RKManagedObjectMapping *)signalMappingInObjectStore: (RKManagedObjectStore*) store {
    RKManagedObjectMapping *signalMapping = [RKManagedObjectMapping mappingForEntityWithName:@"Signal" inManagedObjectStore:store];
    [signalMapping mapKeyPath:@"body" toAttribute:@"body"];
    [signalMapping mapKeyPath:@"best_full_name" toAttribute:@"senderName"];
    [signalMapping mapKeyPath:@"at" toAttribute:@"timestamp"];
    [signalMapping mapKeyPath:@"user_id" toAttribute:@"senderId"];
    //[signalMapping mapKeyPath:@"likers" toAttribute:@"personIdsLikingThis"];
    [signalMapping mapKeyPath:@"signal_id" toAttribute:@"signalId"];
    //[signalMapping mapKeyPath:@"group_ids" toAttribute:@"groupIdsPostedTo"];
    [signalMapping mapKeyPath:@"in_reply_to.signal_id" toAttribute:@"inReplyToSignalId"];
    signalMapping.primaryKeyAttribute = @"signalId";
    return signalMapping;
}

+ (RKManagedObjectMapping *)personMappingInObjectStore: (RKManagedObjectStore*) store {
    RKManagedObjectMapping *personMapping = [RKManagedObjectMapping mappingForEntityWithName:@"Person" inManagedObjectStore:store];

    [personMapping mapKeyPath:@"best_full_name" toAttribute:@"fullName"];
    [personMapping mapKeyPath:@"username" toAttribute:@"username"];
    [personMapping mapKeyPath:@"email" toAttribute:@"email"];
    [personMapping mapKeyPath:@"id" toAttribute:@"personId"];
    [personMapping mapKeyPath:@"personal_url" toAttribute:@"personalHomepage"];
    [personMapping mapKeyPath:@"mobile_phone" toAttribute:@"mobilePhone"];
    [personMapping mapKeyPath:@"work_phone" toAttribute:@"workPhone"];
    [personMapping mapKeyPath:@"home_phone" toAttribute:@"homePhone"];
    [personMapping mapKeyPath:@"twitter_sn" toAttribute:@"twitter"];
    personMapping.primaryKeyAttribute = @"personId";
    return personMapping;
}

+ (RKObjectManager *)objectManager {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:baseurl];
    [objectManager setClient:[RKClient sharedClient]];
    RKManagedObjectStore* objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"iCollective.sqlite"];
    
    objectManager.objectStore = objectStore;
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    objectManager.acceptMIMEType = RKMIMETypeJSON;

    [[objectManager mappingProvider]
        setObjectMapping:[self signalMappingInObjectStore:objectStore] forResourcePathPattern:@"/signals" withFetchRequestBlock:^NSFetchRequest *(NSString *resourcePath) {
        return [NSFetchRequest fetchRequestWithEntityName:@"Signal"];
    }];

    [[objectManager mappingProvider]
        setObjectMapping:[self personMappingInObjectStore:objectStore] forResourcePathPattern:@"/people" withFetchRequestBlock:^NSFetchRequest *(NSString *resourcePath) {
        return [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    }];

    return objectManager;
}


+ (RKRequestQueue *) profilePicQueue {
    RKRequestQueue *queue = [RKRequestQueue requestQueueWithName:@"profilePicQueue"];
    [queue start];
    return queue;
}

+ (void)fetchImage:(NSString *)photoUrl delegate:(id <RKRequestDelegate>) delegate {
    [self.profilePicQueue cancelRequestsWithDelegate:delegate];
    [[RKClient sharedClient] get:photoUrl usingBlock:^(RKRequest *request) {
        request.delegate = delegate;
        request.cacheTimeoutInterval = 24*60*60;
        request.queue = self.profilePicQueue;
    }];
}

@end