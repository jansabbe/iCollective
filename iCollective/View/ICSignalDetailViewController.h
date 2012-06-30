//
//  ICSignalDetailViewController.h
//  iCollective
//
//  Created by Jan Sabbe on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@class ICSimpleSignal;

@interface ICSignalDetailViewController : UIViewController <UIWebViewDelegate, RKRequestDelegate>
@property(weak, nonatomic) IBOutlet UILabel *senderLabel;
@property(weak, nonatomic) IBOutlet UIWebView *signalTextView;
@property(weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property(weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property(nonatomic, strong) ICSimpleSignal *signal;
@end
