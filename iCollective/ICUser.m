#import "ICUser.h"
#import <RestKit/RestKit.h>
#import "ICRestKitConfiguration.h"


@interface ICUser ()

@end

@implementation ICUser
@synthesize userName = _userName;
@synthesize password = _password;

- (ICUser *)initWithUsername:(NSString *)userName andPassword:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}

+ (ICUser *)currentUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults stringForKey:USERNAME_KEY];
    NSString *password = [userDefaults stringForKey:PASSWORD_KEY];

    return [[ICUser alloc] initWithUsername:username andPassword:password];
}

- (void)setUsername:(NSString *)username andPassword:(NSString *)password {
    if ([username rangeOfString:@"@"].location == NSNotFound) {
        _userName = [username stringByAppendingString:@"@cegeka.be"];
    } else {
        _userName = username;
    }
    _password = password;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.userName forKey:USERNAME_KEY];
    [userDefaults setObject:self.password forKey:PASSWORD_KEY];
    [userDefaults synchronize];
}

- (NSString *)profilePageUrl {
    return [NSString stringWithFormat:@"/people/%@", self.userName];
}

- (RKRequest *)configureRestKitAndRunIfUserCanLogin:(void (^)())canLoginBlock
                                  ifUserCannotLogin:(void (^)())cannotLoginBlock {
    if (![self hasUsernameAndPassword]) {
        cannotLoginBlock();
        return nil;
    }

    [ICRestKitConfiguration configureRestKitWithUser:self];
    __weak RKRequest *request = [[RKClient sharedClient] get:[self profilePageUrl] delegate:nil];
    [request setOnDidLoadResponse:^void(RKResponse *response) {
        [request cancel];
        canLoginBlock();
    }];

    [request setOnDidFailLoadWithError:^void(NSError *error) {
        [request cancel];
        cannotLoginBlock();
    }];
    return request;
}

- (BOOL)hasUsernameAndPassword {
    return (self.userName && self.password);
}

@end