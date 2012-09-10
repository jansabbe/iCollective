#import "ICPersonCell.h"
#import "ICRestKitConfiguration.h"

@interface ICPersonCell()
@end

@implementation ICPersonCell {
    NSString* _personPhotoUrl;
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    if ([request.resourcePath isEqualToString:_personPhotoUrl]) {
        self.personImage.image = [UIImage imageWithData:response.body];
    }
}

- (void)setPersonUrl:(NSString *)aPersonUrl {
    _personPhotoUrl = aPersonUrl;
    self.personImage.image = nil;
    [ICRestKitConfiguration fetchImage:aPersonUrl delegate:self];
}


- (void) dealloc {
    [[ICRestKitConfiguration profilePicQueue] cancelRequestsWithDelegate:self];
}

@end