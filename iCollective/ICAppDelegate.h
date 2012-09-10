//
//  ICAppDelegate.h
//  iCollective
//
//  Created by Jan Sabbe on 02/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKObjectManager;

@interface ICAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readwrite) RKObjectManager *objectManager;

@end