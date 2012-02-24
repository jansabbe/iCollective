//
//  Created by jansabbe on 24/02/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#define AUTHORIZATION_HEADER @"Authorization"

@interface NSMutableURLRequest (Authentication)

-(void) basicAuthenticationWithUsername:(NSString *) username password:(NSString *)password;
@end