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

+ (SocialtextHttpConnection *)socialtextHttpConnection:(NSString *)relativeUrl andExecute:(void (^)(NSURLResponse *, NSData *, NSError *))successCallback;

- (SocialtextHttpConnection *)initWithUrl:(NSURL *)url callback:(void (^)(NSURLResponse *, NSData *, NSError *))callback;

- (void)sendGet;

@end