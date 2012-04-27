//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RKClient;
@class RKObjectManager;
static NSString *const baseurl = @"https://cegeka.socialtext.net/data/";
static NSString *const username = @"tom.toutenel@cegeka.be"; //TODO
static NSString *const password = @"albert0B"; //TODO


@interface ICRestKitConfiguration : NSObject
+ (RKClient*)configureRestKit;

+ (RKObjectManager *)objectManager;
@end