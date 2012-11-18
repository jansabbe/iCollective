//
//  ICSignalCell.m
//  iCollective
//
//  Created by Jan Sabbe on 7/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalCell.h"

@interface ICSignalCell () {
    NSString *_senderPhotoUrl;
}
@end

@implementation ICSignalCell


- (void)setSenderPhotoUrl:(NSString *)senderPhotoUrl {
    _senderPhotoUrl = senderPhotoUrl;
    self.senderImage.image = [UIImage imageNamed:@"profile"];
}

- (void)setIsPartOfConversation:(BOOL)anIsPartOfConversation {
    [self.replyToImage setHidden:!anIsPartOfConversation];
}


@end
