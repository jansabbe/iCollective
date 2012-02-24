//
//  Created by jansabbe on 24/02/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSMutableURLRequest+Authentication.h"
#import "NSData+Base64.h"



@implementation NSMutableURLRequest (Authentication)

- (void)basicAuthenticationWithUsername:(NSString *)username password:(NSString *)password {
    NSString *authenticationHeader = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *data = [authenticationHeader dataUsingEncoding:NSUTF8StringEncoding];
    NSString *basicHeader = [NSString stringWithFormat:@"Basic %@", [data base64EncodedString]];
    [self setValue:basicHeader forHTTPHeaderField:AUTHORIZATION_HEADER];
}

@end