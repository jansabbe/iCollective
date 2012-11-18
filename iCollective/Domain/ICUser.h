#import <Foundation/Foundation.h>


#define USERNAME_KEY @"username"
#define PASSWORD_KEY @"password"

@class ICSocialTextAPI;

@interface ICUser : NSObject

@property(readonly, nonatomic) NSString *userName;
@property(readonly, nonatomic) NSString *password;

+ (ICUser *)currentUser;

- (ICUser *)initWithUsername:(NSString *)userName andPassword:(NSString *)password;

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

- (ICSocialTextAPI *)socialTextClient;

- (void)ifUserCanLogin:(void (^)())canLoginBlock ifUserCannotLogin:(void (^)())cannotLoginBlock;


@end