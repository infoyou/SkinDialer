#import <UIKit/UIKit.h>
#import "CallDialerPad.h"
#import "BottomButtonBar.h"
#import "BottomDualButtonBar.h"
#import "MenuCallView.h"
#import "LCDView.h"
#import "DualButtonView.h"
#import "ABContentUtil.h"
#import "SqliteUtil.h"
#import "RecentCallBean.h"

@interface CallViewController : UIViewController<PhonePadDelegate,
MenuCallViewDelegate, DualButtonViewDelegate>
{
	LCDView             *_callTextView;
	
	UIView              *_switchViews[2];
	NSUInteger           _whichView;
	UIView		      *_containerView;
	CallDialerPad            *_keyPad;
	MenuCallView        *_menuView;
	
	DualButtonView      *_buttonView;
	BottomButtonBar     *_bottomBar;
	
	UIButton			  *_endCallLongButton;
	BottomDualButtonBar *_endCallButton;
	UIButton            *_hideButton;
	
	BottomDualButtonBar *_dualBottomBar;
	
	NSTimer *_timer;
	NSString *_callNum;
	NSString *_curText;
	
	int intervalTime;
    NSString *_fromIndex;
}

@property (nonatomic, retain)  NSString *_callNum;
@property (nonatomic, retain)  NSString *_fromIndex;

- (void)showCallNumber:(NSString *)string;

@end
