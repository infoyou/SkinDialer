//
//  SkinDialerAppDelegate.h
//  SkinDialer
//
//  Created by Joseph on 11-5-18.
//  Copyright 2011 iBizChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiveViewController.h"

@class SkinDialerViewController;

@interface SkinDialerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SkinDialerViewController *viewController;
    UITabBarController *tabBarController;
    ReceiveViewController *_ReceiveViewController;
    
    NSString* deviceToken;
    NSString* payload;
    NSString* certificate;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SkinDialerViewController *viewController;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) ReceiveViewController *_ReceiveViewController;

@property (nonatomic, retain) NSString* deviceToken;
@property (nonatomic, retain) NSString* payload;
@property (nonatomic, retain) NSString* certificate;

@end

