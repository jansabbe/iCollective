//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@class RKClient;
@class RKObjectManager;
@class ICUser;
static NSString *const baseurl = @"https://cegeka.socialtext.net/data/";


@interface ICRestKitConfiguration : NSObject
+ (RKClient *)configureRestKitWithUser:(ICUser *)user;

+ (RKObjectManager *)objectManager;

+ (RKManagedObjectMapping *)personMappingInObjectStore: (RKManagedObjectStore*) store;

+ (RKManagedObjectMapping *)signalMappingInObjectStore: (RKManagedObjectStore*) store;

@end