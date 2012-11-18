#import "ICImageCell.h"

@interface ICImageCell ()
@end

@implementation ICImageCell {
    NSString *_photoUrl;
}

- (void)setSocialTextImageUrl:(NSString *)aSocialTextImageUrl {
    _photoUrl = aSocialTextImageUrl;
    self.socialTextImage.image = [UIImage imageNamed:@"profile"];
}

- (void)dealloc {
}

@end