//
//  ICSignalCell.h
//  iCollective
//
//  Created by Jan Sabbe on 7/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface ICSignalCell : UITableViewCell <RKRequestDelegate>
@property(weak, nonatomic) IBOutlet UILabel *signalTextLabel;
@property(weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property(weak, nonatomic) IBOutlet UIImageView *senderImage;
@property(weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property(weak, nonatomic) IBOutlet UIImageView *replyToImage;

@property(strong, nonatomic) NSString* senderPhotoUrl;

@end
