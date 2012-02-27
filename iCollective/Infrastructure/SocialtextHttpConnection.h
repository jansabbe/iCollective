//
//  Created by jansabbe on 24/02/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface SocialtextHttpConnection : NSObject
@property(nonatomic, strong, readonly) NSURL *url;
@property(nonatomic, strong, readonly) void (^callback)(NSURLResponse *, NSData *data, NSError *error);
@property(nonatomic, readonly) BOOL isReceiving;

+ (SocialtextHttpConnection *)socialtextHttpConnection:(NSString *)relativeUrl username:(NSString *)username password:(NSString *)password callback:(void (^)(NSURLResponse *, NSData *, NSError *))handler;

- (SocialtextHttpConnection *)initWithUrl:(NSURL *)url username:(NSString *)username password:(NSString *)password callback:(void (^)(NSURLResponse *, NSData *, NSError *))successCallback;

- (void)sendGet;

@end