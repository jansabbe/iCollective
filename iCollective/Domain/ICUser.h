#import <Foundation/Foundation.h>

@class RKRequest;

#define USERNAME_KEY @"username"
#define PASSWORD_KEY @"password"


@interface ICUser : NSObject

@property(readonly, nonatomic) NSString *userName;
@property(readonly, nonatomic) NSString *password;

- (ICUser *)initWithUsername:(NSString *)userName andPassword:(NSString *)password;

+ (ICUser *)currentUser;

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

- (RKRequest *)configureRestKitAndRunIfUserCanLogin:(void (^)())canLoginBlock
                                  ifUserCannotLogin:(void (^)())cannotLoginBlock;
@end