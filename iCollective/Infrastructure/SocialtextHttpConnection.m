//
//  Created by jansabbe on 24/02/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SocialtextHttpConnection.h"
#import "NSMutableURLRequest+Authentication.h"


#define SOCIALTEXT_BASE_URL [NSURL URLWithString:@"https://cegeka.socialtext.net"]

@implementation SocialtextHttpConnection {
    NSString *_username;
    NSString *_password;
}

@synthesize url = _url;
@synthesize callback = _callback;
@synthesize isReceiving = _receiving;

+ (SocialtextHttpConnection *)socialtextHttpConnection:(NSString *)relativeUrl username:(NSString *)username password:(NSString *)password callback:(void (^)(NSURLResponse *, NSData *, NSError *))handler {
    NSURL *url = [NSURL URLWithString:relativeUrl relativeToURL:SOCIALTEXT_BASE_URL];
    return [[SocialtextHttpConnection alloc] initWithUrl:url username:username password:password callback:handler];
}

- (SocialtextHttpConnection *)initWithUrl:(NSURL *)url username:(NSString *)username password:(NSString *)password callback:(void (^)(NSURLResponse *, NSData *, NSError *))successCallback {
    self = [super init];
    if (self) {
        _url = url;
        _callback = successCallback;
        _username = username;
        _password = password;
    }
    return self;
}

- (void)sendGet {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request basicAuthenticationWithUsername:_username password:_password];
    _receiving = YES;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        _receiving = NO;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (_callback) {
            _callback(response, data, error);
        }

    }];
}
@end