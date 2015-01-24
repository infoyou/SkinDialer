#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

#import "DialerPhonePad.h"
#import "LCDPhoneView.h"
#import "CallViewController.h"

@interface PhoneViewController : UIViewController <
UITextFieldDelegate,
PhonePadDelegate,
UIActionSheetDelegate,
ABNewPersonViewControllerDelegate,
ABPeoplePickerNavigationControllerDelegate>
{
	UITextField *_textfield;
	LCDPhoneView  *_lcd;
	
	DialerPhonePad *_pad;
	
	UIView      *_container;
	UIButton *_addContactButton;
	
	UIButton *_callButton;
	
	UIButton *_deleteButton;
	int      _deletedChar;
	NSTimer *_deleteTimer;
	
	NSString *_lastNumber;
	
	ABPeoplePickerNavigationController *peoplePickerCtrl;
	
	NSTimer  *_callButtonTimer;
	
	CallViewController *_callPicker;
}

@end

