//
//  ICSignalDetailViewController.m
//  iCollective
//
//  Created by Jan Sabbe on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalDetailViewController.h"
#import "ICSignal.h"

@interface ICSignalDetailViewController ()

@end

@implementation ICSignalDetailViewController
@synthesize senderLabel = _senderLabel;
@synthesize signalTextView = _signalTextView;
@synthesize profilePhotoView = _profilePhotoView;
@synthesize signal = _signal;
@synthesize timestampLabel = _timestampLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.senderLabel.text = self.signal.sender.fullName;
    self.timestampLabel.text = self.signal.fuzzyTimestamp;

    [self.signalTextView loadHTMLString:[self bodyAsHtml]
                                baseURL:[NSURL URLWithString:@"https://cegeka.socialtext.net/"]];
    [self.signalTextView setDelegate:self];
    [self.signalTextView.scrollView setScrollEnabled:NO];
    [self.signalTextView.scrollView setBounces:NO];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}

- (NSString *)bodyAsHtml {
    return [NSString stringWithFormat:@"<html><head><style>* {font-family: Helvetica; font-size: 14; border:0px; padding:0px; margin:0px;}</style></head><body>%@</body></html>",
                                      self.signal.body];

}

@end
