//
//  SkinDialerAppDelegate.m
//  SkinDialer
//
//  Created by Adam on 11-5-18.
//  Copyright 2011 iBizChina. All rights reserved.
//

#import "SkinDialerAppDelegate.h"
#import <AddressBookUI/AddressBookUI.h>
#import "SkinDialerViewController.h"
#import "ReceiveViewController.h"
#import "RecentCallController.h"
#import "ABRootViewController.h"
#import "PhoneViewController.h"
#import "AppSettings.h"
#import "SqliteUtil.h"

@implementation SkinDialerAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize tabBarController;
@synthesize _ReceiveViewController;

@synthesize deviceToken;
@synthesize payload;
@synthesize certificate;

#pragma mark - Application lifecycle
- (void)setupMainUserInterface
{
	UINavigationController *localNav;
	
	// Create a tabBar controller and an array to contain the view controllers
	tabBarController = [[UITabBarController alloc] init];
	NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:5];
	
	// Setup the view controllers
	/* Settings */
	AppSettings *settings = [[[AppSettings alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	localNav = [[UINavigationController alloc] initWithRootViewController:settings];
	localNav.navigationBar.barStyle = UIBarStyleDefault;
	[localViewControllersArray addObject:localNav];
	[localNav release];
	
	/* Recent Call*/
	RecentCallController *recents = [[[RecentCallController alloc] initWithStyle:UITableViewStylePlain] autorelease];
	localNav = [[UINavigationController alloc] initWithRootViewController:recents];
	localNav.navigationBar.barStyle = UIBarStyleDefault;
	[localNav.navigationBar enableAnimation];
	[localViewControllersArray addObject:localNav];
	[localNav release];
	
	/* Pad */
	PhoneViewController *phone = [[PhoneViewController alloc] init];
	[localViewControllersArray addObject:phone];
	[phone release];
	
	/* Contacts */
    ABRootViewController *picker = [[ABRootViewController alloc] initWithStyle]; 
	picker.peoplePickerDelegate = picker; 
	[localViewControllersArray addObject:picker];
    [picker release]; 
    
    //	ABPeoplePickerNavigationController *peopleCtrl = [[ABPeoplePickerNavigationController alloc] init];
    //	peopleCtrl.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:'cont'];
    
    //	peopleCtrl.navigationBar.topItem.prompt = @"MyTitle";
    //	[peopleCtrl setDisplayedProperties:[NSArray arrayWithObject:NUMBER(kABPersonPhoneProperty)]];
    //	[self presentModalViewController:peopleCtrl animated:YES];
	
    //	[localViewControllersArray addObject:peopleCtrl];	
    //	[peopleCtrl release];
	
	// Set the tab bar controller view.
	tabBarController.viewControllers = localViewControllersArray;
	
	// The localViewControllersArray is now retained by the tabBarController
	// so we can release the local version
	[localViewControllersArray release];
	
	tabBarController.selectedIndex = 0;
	
	// Set the window subview as the tab bar controller
	[self.window addSubview: tabBarController.view];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
	
    [SqliteUtil openDB];
	[SqliteUtil createTable];
    
    [self setupMainUserInterface];
    
    NSLog(@"Registering for push notifications..."); 
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | 
                                                                           UIRemoteNotificationTypeSound |
                                                                           UIRemoteNotificationTypeAlert)];
    
    //    [application setApplicationIconBadgeNumber:6];
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //    CallViewController *call = [[CallViewController alloc] init];
    //    call._callNum = [NSString stringWithFormat:@"@d", 110];
    //    [self addv:call animated:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
    [_ReceiveViewController release];
    [viewController release];
    [window release];
    
    [deviceToken release];
    [payload release];
    [certificate release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@" handleOpenURL ");
    if (!url) {
        return NO;
    }else{
        NSArray *array = [[url absoluteString]  componentsSeparatedByString:@"//"];
        if ([[array objectAtIndex:1] isEqualToString:@"ActiveCall"]) {
            // switch to call view
            if (_ReceiveViewController == nil) {
                _ReceiveViewController = [[ReceiveViewController alloc] init];
            }
            _ReceiveViewController._callNum = [array objectAtIndex:2];
            _ReceiveViewController._fromIndex = [NSString stringWithFormat:@"%d",1];
            [self.window addSubview:_ReceiveViewController.view];
        }else if([[array objectAtIndex:1] isEqualToString:@"Decline"]) {
            // switch to call view
            [_ReceiveViewController endCall];
            [_ReceiveViewController release];
        }
    }
    return YES;
}

@end
