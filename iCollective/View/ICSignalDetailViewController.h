//
//  ICSignalDetailViewController.h
//  iCollective
//
//  Created by Jan Sabbe on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICSignal;

@interface ICSignalDetailViewController : UIViewController <UIWebViewDelegate>
@property(weak, nonatomic) IBOutlet UILabel *senderLabel;
@property(weak, nonatomic) IBOutlet UIWebView *signalTextView;
@property(weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property(weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property(nonatomic, strong) ICSignal *signal;
@end
