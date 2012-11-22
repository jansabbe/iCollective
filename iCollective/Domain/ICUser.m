#import "ICUser.h"
#import "NSString+ICUtils.h"
#import <AFNetworking/AFNetworking.h>
#import <AFIncrementalStore/AFRESTClient.h>

#import "ICSocialTextAPI.h"


@interface ICUser ()
@property(readwrite, nonatomic) NSString *userName;
@property(readwrite, nonatomic) NSString *password;
@end

@implementation ICUser {
    ICSocialTextAPI *_socialTextClient;
}

+ (ICUser *)currentUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults stringForKey:USERNAME_KEY];
    NSString *password = [userDefaults stringForKey:PASSWORD_KEY];
    return [[ICUser alloc] initWithUsername:username andPassword:password];
}

- (ICUser *)initWithUsername:(NSString *)userName andPassword:(NSString *)password {
    self = [super init];
    if (self) {
        self.userName = userName;
        self.password = password;
    }
    return self;
}

- (void)setUsername:(NSString *)username andPassword:(NSString *)password {
    if (![username contains:@"@"]) {
        self.userName = [username stringByAppendingString:@"@cegeka.be"];
    } else {
        self.userName = username;
    }
    self.password = password;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _socialTextClient = nil;
    [userDefaults setObject:self.userName forKey:USERNAME_KEY];
    [userDefaults setObject:self.password forKey:PASSWORD_KEY];
    [userDefaults synchronize];
}

- (NSString *)profilePageUrl {
    return [NSString stringWithFormat:@"users/%@", self.userName];
}

- (BOOL)hasUsernameAndPassword {
    return (self.userName && self.password);
}

- (ICSocialTextAPI *)socialTextClient {
    if (!_socialTextClient) {
        _socialTextClient = [ICSocialTextAPI clientForUser:self];
    }
    return _socialTextClient;
}

- (void)ifUserCanLogin:(void (^)())canLoginBlock
     ifUserCannotLogin:(void (^)())cannotLoginBlock {
    if (![self hasUsernameAndPassword]) {
        cannotLoginBlock();
        return;
    }

    [self.socialTextClient getPath:self.profilePageUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        canLoginBlock();
    }                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        cannotLoginBlock();
    }];
}

@end