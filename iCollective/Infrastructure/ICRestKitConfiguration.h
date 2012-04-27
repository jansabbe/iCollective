//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RKClient;


@interface ICRestKitConfiguration : NSObject
+ (RKClient*)configureRestKit;
@end