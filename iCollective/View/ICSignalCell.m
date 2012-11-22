//
//  ICSignalCell.m
//  iCollective
//
//  Created by Jan Sabbe on 7/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalCell.h"
#import "ICSignal.h"

@implementation ICSignalCell


- (void)setIsPartOfConversation:(BOOL)anIsPartOfConversation {
    [self.replyToImage setHidden:!anIsPartOfConversation];
}

- (void)setSignal:(ICSignal *)signal {

    self.signalTextLabel.text = signal.bodyAsPlainText;
    self.senderNameLabel.text = signal.sender.fullName;
    self.timestampLabel.text = signal.fuzzyTimestamp;
    self.replyToImage.hidden = ![signal isPartOfConversation];
    if ([signal isReplyToOtherSignal]) {
        self.replyToImage.image = [UIImage imageNamed:@"transarrow"];
    } else {
        self.replyToImage.image = [UIImage imageNamed:@"speechbaloon"];
    }
};


@end
