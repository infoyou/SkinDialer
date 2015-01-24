//
//  ABRootViewController.h
//  Nav
//
//  Created by on 11-5-10.
//  Copyright 2011 chiefree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h> 
#import <AddressBookUI/AddressBookUI.h> 
#import <UIKit/UIKit.h>
#import "CallViewController.h"

@interface ABRootViewController : ABPeoplePickerNavigationController <ABPeoplePickerNavigationControllerDelegate, 
    ABPersonViewControllerDelegate, 
    ABNewPersonViewControllerDelegate, 
    ABUnknownPersonViewControllerDelegate,
    UIAlertViewDelegate,UIActionSheetDelegate> 
{
    
	NSString *_PersonMsg;
}

@property (nonatomic, retain)  NSString *_PersonMsg;

- (id)initWithStyle;
@end

//@interface ABRootViewController(ABRootView)
//-(void) setAllowsCardEditing:(BOOL)flag;
//-(void) setAllowsCancel:(BOOL)flag;
//- (void) selAllABContent;
//- (id)initWithStyle;
//@end
