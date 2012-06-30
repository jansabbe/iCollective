//
//  ICSignalCell.m
//  iCollective
//
//  Created by Jan Sabbe on 7/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalCell.h"
#import "ICSimpleSignal.h"
#import <RestKit/RestKit.h>

@interface ICSignalCell ()
@property(strong, nonatomic) RKRequest *currentRequestForImage;
@end

@implementation ICSignalCell
@synthesize signal = _signal;
@synthesize senderImage = _senderImage;
@synthesize signalTextLabel = _signalTextLabel;
@synthesize senderNameLabel = _senderNameLabel;
@synthesize currentRequestForImage = _currentRequestForImage;
@synthesize timestampLabel = _timestampLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)updateUI {
    [self.currentRequestForImage cancel];
    self.senderImage.image = nil;
    self.senderNameLabel.text = self.signal.senderName;
    self.signalTextLabel.text = self.signal.bodyAsPlainText;
    self.timestampLabel.text = self.signal.fuzzyTimestamp;
    self.currentRequestForImage = [[RKClient sharedClient] get:self.signal.senderPhotoUrl delegate:self];

}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    self.senderImage.image = [UIImage imageWithData:response.body];
}

- (void)setSignal:(ICSimpleSignal *)aSignal {
    _signal = aSignal;
    [self updateUI];
}


@end
