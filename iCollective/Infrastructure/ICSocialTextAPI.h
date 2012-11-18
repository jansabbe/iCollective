//
//  ICSocialTextAPI.h
//  iCollective
//
//  Created by Jan Sabbe on 14/11/12.
//
//

#import <Foundation/Foundation.h>
#import <AFIncrementalStore/AFRESTClient.h>

@class ICUser;

@interface ICSocialTextAPI : AFRESTClient
+ (ICSocialTextAPI *)sharedClient;

+ (ICSocialTextAPI *)clientForUser:(ICUser *)user;


@end
