//
//  ICSignalDetailViewController.m
//  iCollective
//
//  Created by Jan Sabbe on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICSignalDetailViewController.h"
#import "ICSimpleSignal.h"

@interface ICSignalDetailViewController ()

@end

@implementation ICSignalDetailViewController
@synthesize senderLabel = _senderLabel;
@synthesize signalTextView = _signalTextView;
@synthesize profilePhotoView = _profilePhotoView;
@synthesize signal = _signal;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.senderLabel.text = self.signal.senderName;

    [[RKClient sharedClient] get:self.signal.senderPhotoUrl delegate:self];
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

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    self.profilePhotoView.image = [UIImage imageWithData:response.body];
}

- (NSString *)bodyAsHtml {
    return [NSString stringWithFormat:@"<html><head><style>* {font-family: Helvetica; font-size: 17; border:0px; padding:0px; margin:0px;}</style></head><body>%@</body></html>",
                                      self.signal.body];

}

@end