#import "ICImageCell.h"
#import "ICRestKitConfiguration.h"

@interface ICImageCell ()
@end

@implementation ICImageCell {
    NSString*_photoUrl;
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    if ([request.resourcePath isEqualToString:_photoUrl]) {
        self.socialTextImage.image = [UIImage imageWithData:response.body];
    }
}

- (void)setSocialTextImageUrl:(NSString *)aSocialTextImageUrl {
    _photoUrl = aSocialTextImageUrl;
    self.socialTextImage.image = [UIImage imageNamed:@"profile"];
    [ICRestKitConfiguration fetchImage:aSocialTextImageUrl delegate:self];
}

- (void) dealloc {
    [[ICRestKitConfiguration profilePicQueue] cancelRequestsWithDelegate:self];
}

@end