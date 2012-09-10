//
//  ICSignalCell.m
//  iCollective
//
//  Created by Jan Sabbe on 7/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalCell.h"
#import "ICRestKitConfiguration.h"
#import <RestKit/RestKit.h>

@interface ICSignalCell () {
    NSString* _senderPhotoUrl;
}
@end

@implementation ICSignalCell


- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    if ([request.resourcePath isEqualToString:_senderPhotoUrl]) {
        self.senderImage.image = [UIImage imageWithData:response.body];
    }
}

- (void) setSenderPhotoUrl:(NSString *)senderPhotoUrl {
    _senderPhotoUrl = senderPhotoUrl;
    self.senderImage.image = nil;
    [ICRestKitConfiguration fetchImage:senderPhotoUrl delegate:self];
}

- (void)setIsPartOfConversation:(BOOL)anIsPartOfConversation {
    [self.replyToImage setHidden:!anIsPartOfConversation];
}



- (void) dealloc {
    [[ICRestKitConfiguration profilePicQueue] cancelRequestsWithDelegate:self];
}

@end
