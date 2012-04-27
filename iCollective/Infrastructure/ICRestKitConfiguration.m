//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICRestKitConfiguration.h"
#import <RestKit/RestKit.h>


@implementation ICRestKitConfiguration {

}

+ (RKClient*)configureRestKit {
    [RKClient setSharedClient:[RKClient clientWithBaseURLString:@"https://cegeka.socialtext.net/data/"]];
    [[RKClient sharedClient] setAuthenticationType:RKRequestAuthenticationTypeHTTPBasic];
    [[RKClient sharedClient] setUsername:@"jan.sabbe@cegeka.be"];
    [[RKClient sharedClient] setPassword:@"SJOKOE"];
    return [RKClient sharedClient];

}
@end