#import <UIKit/UIKit.h>
#import "CallDialerPad.h"
#import "BottomButtonBar.h"
#import "BottomDualButtonBar.h"
#import "MenuCallView.h"
#import "LCDView.h"
#import "DualButtonView.h"
#import "RecentCallBean.h"
#import "ABContentUtil.h"
#import "SqliteUtil.h"

@interface ReceiveViewController : UIViewController<PhonePadDelegate,
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
	
	BottomDualButtonBar *_endCallButton;
	UIButton            *_hideButton;
	UIButton	*_endCallLongButton;
	BottomDualButtonBar *_dualBottomBar;
	
	NSTimer *_timer;
	NSString *_callNum;
    NSString *_fromIndex;
	NSString *_curText;
	
	int intervalTime;
	bool isCalling;
	
}

@property (nonatomic, retain)  NSString *_callNum;
@property (nonatomic, retain)  NSString *_fromIndex;

- (void)endCall;

@end
