//
//  Created by jansabbe on 24/02/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SocialtextHttpConnection.h"
#import "NSMutableURLRequest+Authentication.h"


#define SOCIALTEXT_BASE_URL [NSURL URLWithString:@"https://cegeka.socialtext.net"]
#define TODO_USERNAME @"DUMMY"
#define TODO_PASSWORD @"DUMMY"

@implementation SocialtextHttpConnection {

}

@synthesize url = _url;
@synthesize callback = _callback;
@synthesize isReceiving = _receiving;

+ (SocialtextHttpConnection *)socialtextHttpConnection:(NSString *)relativeUrl andExecute:(void (^)(NSURLResponse *, NSData *, NSError *))handler {
    NSURL *url = [NSURL URLWithString:relativeUrl relativeToURL:SOCIALTEXT_BASE_URL];
    return [[SocialtextHttpConnection alloc] initWithUrl:url callback:handler];
}

- (SocialtextHttpConnection *)initWithUrl:(NSURL *)url callback:(void (^)(NSURLResponse *, NSData *, NSError *))successCallback {
    self = [super init];
    if (self) {
        _url = url;
        _callback = successCallback;
    }
    return self;
}


- (void)sendGet {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request basicAuthenticationWithUsername:TODO_USERNAME password:TODO_PASSWORD];
    _receiving = YES;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        _receiving = NO;
        NSLog(@"error %@", error);
        _callback(response, data, error);
    }];
}
@end