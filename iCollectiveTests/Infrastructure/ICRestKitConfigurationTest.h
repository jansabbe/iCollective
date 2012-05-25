//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>

@interface ICRestKitConfigurationTest : SenTestCase <RKRequestDelegate>
- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error;

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response;
@end