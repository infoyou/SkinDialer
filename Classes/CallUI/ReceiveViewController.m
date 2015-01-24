#import "ReceiveViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AddressBook/AddressBook.h>
#import "BottomBar.h"

#define HOLD_ON 1
#define CYDIA 0
#define kTransitionDuration	0.5

@interface ReceiveViewController (private)

- (void)setSpeakerPhoneEnabled:(BOOL)enable;
- (void)setMute:(BOOL)enable;

@end

@implementation ReceiveViewController

@synthesize _callNum;
@synthesize _fromIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	NSLog(@"ReceiveViewController::initWithNibName");
	return self;
}

- (void)loadView
{
	NSLog(@"ReceiveViewController::loadView");
	
	UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	
#if defined(CYDIA) && (CYDIA == 1)
	[view setBackgroundColor:[[[UIColor alloc] 
							   initWithPatternImage:[UIImage defaultDesktopImage]]
							  autorelease]];
#else
	[view setBackgroundColor:[UIColor blackColor]];
	//[view setBackgroundColor:[UIColor whiteColor]];
#endif                            
	
	// create the container view which we will use for transition animation (centered horizontally)s
	CGRect frame = CGRectMake(0.0f, 70.0f, 320.0f, 320.0f);
	_containerView = [[UIView alloc] initWithFrame:frame];
	[view addSubview:_containerView];
	
	/** key Pad **/
	_keyPad = [[CallDialerPad alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
    [_keyPad setPlaysSounds: TRUE];
	//[_keyPad setPlaysSounds:[[NSUserDefaults standardUserDefaults] boolForKey:@"keypadPlaySound"]];
	[_keyPad setDelegate: self];
	//	[_containerView addSubview:_keyPad];
	
	/** Menu **/
	_menuView = [[MenuCallView alloc] initWithFrame: CGRectMake(18.0f, 52.0f, 285.0f, 216.0f)];
	
	[_menuView setTitle:NSLocalizedString(@"mute", @"Call View")
				  image:[UIImage imageNamed:@"mute.png"] forPosition:0];
	[_menuView setTitle:NSLocalizedString(@"keypad", @"Call View")
				  image:[UIImage imageNamed:@"dialer.png"] forPosition:1];
	[_menuView setTitle:NSLocalizedString(@"speaker", @"Call View")
				  image:[UIImage imageNamed:@"speaker.png"] forPosition:2];
	//  [_menuView setTitle:NSLocalizedString(@"add call", @"Call View")
	//               image:[UIImage imageNamed:@"addcall.png"] forPosition:3];
	
	
#if HOLD_ON
	[_menuView setTitle:NSLocalizedString(@"hold", @"Call View")
				  image:[UIImage imageNamed:@"hold.png"] forPosition:4];
#endif
	
	[_menuView setDelegate:self];
	[_containerView addSubview:_menuView];
	
	_switchViews[0] = _keyPad;
	_switchViews[1] = _menuView;
	
	_whichView = 0; 
	
	/** Dual Button View **/
    //	_buttonView = [[DualButtonView alloc] initWithFrame: CGRectMake(18.0f, 52.0f, 285.0f, 216.0f)];
    //	[_buttonView setDelegate:self];
    //	[_buttonView setTitle:NSLocalizedString(@"Ignore", @"Call View") image:nil forPosition:0];
    //	[_buttonView setTitle:NSLocalizedString(@"Hold Call + Answer", @"Call View") image:nil forPosition:1];
    //	[view addSubview:_buttonView];
	
    //	_bottomBar = [[BottomButtonBar alloc] initForIncomingCallWaiting];
    //	[[_bottomBar button] addTarget:self action:@selector(endCall)
    //				  forControlEvents:UIControlEventTouchUpInside];
	
	/** Title **/
	_callTextView = [[LCDView alloc] initWithDefaultSize];
	[_callTextView setLabel:[ABContentUtil selNameByNumber:_callNum]]; // name or number of callee
	[_callTextView setText:NSLocalizedString(@"calling", @"Call View")];   // timer, call state for example
	[view addSubview: _callTextView];
	
	// endCallButton
	_endCallButton = [[BottomDualButtonBar alloc] initForEndCall];	
	[[_endCallButton button] addTarget:self action:@selector(endCall)
					  forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:_endCallButton];
	
	//	hideButton
	UIImage *buttonBackground = [UIImage imageNamed:@"bottombarblue.png"];
	UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombarblue_pressed.png"];
	
	_hideButton = [BottomButtonBar createButtonWithTitle:NSLocalizedString(@"Hide Keypad", @"Call View")
												   image:nil 
												   frame:CGRectZero 
											  background:buttonBackground
									   backgroundPressed:buttonBackgroundPressed];
	
	[_hideButton addTarget:self action:@selector(hideKeypad) 
		  forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:_hideButton];
	
	_endCallButton.hidden = YES;
	_hideButton.hidden = YES;
	
	//	_endCallLongButton
	UIImage *endCallLongButtonBackground = [UIImage imageNamed:@"bottombarred"];
    UIImage *endCallLongButtonBackgroundPressed = [UIImage imageNamed:@"bottombarred_pressed"];
    UIImage *image = [UIImage imageNamed:@"decline"];
	_endCallLongButton = [BottomButtonBar createButtonWithTitle: NSLocalizedString(@"End Call", @"CallView")
														  image: image
														  frame: CGRectMake(DEFAULT_POSX, DEFAULT_POSY, DEFAULT_WIDTH-20, DEFAULT_HEIGHT/2)
													 background: endCallLongButtonBackground
											  backgroundPressed: endCallLongButtonBackgroundPressed];
	
	[_endCallLongButton setCenter:CGPointMake(DEFAULT_WIDTH/2, DEFAULT_POSY + DEFAULT_HEIGHT/2)];
	[_endCallLongButton addTarget:self action:@selector(endCall) forControlEvents:UIControlEventTouchUpInside];
	
	[view addSubview:_endCallLongButton];
	
	_endCallLongButton.hidden = YES;
	
	_dualBottomBar = [[BottomDualButtonBar alloc] initForIncomingCallWaiting];
	[[_dualBottomBar button] addTarget:self action:@selector(rejectCallDown)
					  forControlEvents:UIControlEventTouchUpInside];
	[[_dualBottomBar button2] addTarget:self action:@selector(answerCallDown)
					   forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:_dualBottomBar];
	self.view = view;
	[view release];
	
}

- (void) viewDidLoad
{	
	// receive from device msg	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc
{
	[_hideButton release];
	[_endCallButton release];
	[_dualBottomBar release];
	[_fromIndex release];
    
	[_keyPad release];
	[_menuView release];
	[_switchViews[0] release];
	[_switchViews[1] release];
	[_containerView release];
	[_curText release];
	[_callTextView release];
	[_bottomBar release];
	[_buttonView release];
	
	[super dealloc];
}

- (void)showKeypad:(BOOL)display animated:(BOOL)animated
{
	if ([_endCallButton superview]) {
		[_endCallButton setButton2:(display ? _hideButton : nil)];
	}
	
	
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:kTransitionDuration];
		
		[UIView setAnimationTransition:(display ?
										UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
							   forView:_containerView cache:YES];
	}
	
	if (display)
	{
		[_switchViews[1] removeFromSuperview];
		[_containerView addSubview:_switchViews[0]];
		_whichView = 0;
		if (isCalling) {
			_endCallLongButton.hidden = YES;
		}else {
			_dualBottomBar.hidden = YES;			
		}
		_endCallButton.hidden = NO;
		_hideButton.hidden = NO;
	}
	else
	{
		[_switchViews[0] removeFromSuperview];
		[_containerView addSubview:_switchViews[1]];
		_whichView = 1;
	}
	
	if (animated)
		[UIView commitAnimations];
}

- (void)hideKeypad
{
	NSLog(@"ReceiveViewController::hideKeypad");
	[self showKeypad:NO animated:YES];
	if (isCalling) {
		_endCallLongButton.hidden = NO;
	}else {
		_dualBottomBar.hidden = NO;
	}
    
	_endCallButton.hidden = YES;
	_hideButton.hidden = YES;
}

- (void)showView:(UIView *)view display:(BOOL)display animated:(BOOL)animated
{
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:kTransitionDuration];
		
		[UIView setAnimationTransition:(display ?
										UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
							   forView:_containerView cache:YES];
	}
	
	if (display)
	{
		[_switchViews[_whichView] removeFromSuperview];
		[_containerView addSubview:view];
	}
	else
	{
		[view removeFromSuperview];
		[_containerView addSubview:_switchViews[_whichView]];
	}
	
	if (animated)
		[UIView commitAnimations];
}

- (void)endingCall
{
    if ([_fromIndex intValue] == 1) {
        [self.view removeFromSuperview];
    }else{
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

- (void)endCall
{
	[self setSpeakerPhoneEnabled:NO];
	[self setMute:NO];
	
	if (_timer)
	{
		[_timer invalidate];
        //		[_timer release];
		_timer = nil;
	}
	[_callTextView setText: NSLocalizedString(@"call ended", nil)];
	[_dualBottomBar removeFromSuperview];
	[_endCallButton removeFromSuperview];
	[_containerView removeFromSuperview];
	[_endCallLongButton removeFromSuperview];
    
	// FIXME not here
	MenuCallView *_menuView = (MenuCallView *)_switchViews[1];
	[[_menuView buttonAtPosition:0] setSelected:NO];
	[[_menuView buttonAtPosition:2] setSelected:NO];
#if HOLD_ON
	[[_menuView buttonAtPosition:4] setSelected:NO];
#endif
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(endingCall) userInfo:nil repeats:NO];
    
    //	Save to sqlite	
	RecentCallBean *recentCall = [[RecentCallBean alloc] init];
	recentCall.T_PhoneNumber = _callNum;
	recentCall.T_CallDate = [NSDate date];
	recentCall.T_CallDuration = [NSString stringWithFormat:@"%d", intervalTime];
	recentCall.T_CallFlag = [NSString stringWithFormat:@"%d", 2];
	[SqliteUtil insertDB:recentCall];
	[recentCall release];
    _callNum = nil;
    
}

- (void)rejectCallDown
{
	NSLog(@"rejectCallDown method");
	
	//	Save to sqlite	
	RecentCallBean *recentCall = [[RecentCallBean alloc] init];
	recentCall.T_PhoneNumber = _callNum;
	recentCall.T_CallDate = [NSDate date];
	recentCall.T_CallDuration = [NSString stringWithFormat:@"%d", 0];
	recentCall.T_CallFlag = [NSString stringWithFormat:@"%d", 0];
	[SqliteUtil insertDB:recentCall];
	[recentCall release];
    _callNum = nil;
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)answerCallDown
{
	NSLog(@"answerCallDown method");
    
	isCalling = YES;
	_dualBottomBar.hidden = YES;
	_endCallLongButton.hidden = NO;
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(callTime) userInfo:nil repeats:YES];
}

- (void)callTime
{
	intervalTime++;
	
	if (intervalTime >= 3600)
	{
		long sec = intervalTime % 3600;
		[_callTextView setText:[NSString stringWithFormat:@"%d:%02d:%02d",
								intervalTime / 3600,
								sec/60, sec%60]];
	}
	else
	{
		[_callTextView setText:[NSString stringWithFormat:@"%02d:%02d",
								(intervalTime)/60,
								(intervalTime)%60]];
	}
}

- (void)setSpeakerPhoneEnabled:(BOOL)enable
{
	UInt32 route;
	route = enable ? kAudioSessionOverrideAudioRoute_Speaker : 
	kAudioSessionOverrideAudioRoute_None;
	AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute, 
							 sizeof(route), &route);
}

- (void)setMute:(BOOL)enable
{
}

- (void)setHoldEnabled: (BOOL)enable
{
}

#pragma mark MenuCallView
- (void)menuButtonClicked:(NSInteger)num
{
	UIButton *button;
	MenuCallView *menuView = (MenuCallView *)_switchViews[1];
	
	button = [menuView buttonAtPosition:num];
	switch (num)
	{
		case 0: // Mute 
			//button = [_menuView buttonAtPosition:num];
			[self setMute:!button.selected];
			[button setSelected:!button.selected];
			break;
		case 1: // Keypad
			[self showKeypad:YES animated:YES];
			break;
		case 2: // Speaker
			//button = [_menuView buttonAtPosition:num];
			[self setSpeakerPhoneEnabled:!button.selected];
			[button setSelected:!button.selected];
			break;
		case 3: // Add call
			break;
		case 4: // Hold
#if HOLD_ON
			//button = [_menuView buttonAtPosition:num];
			[self setHoldEnabled:!button.selected];
			[button setSelected:!button.selected];
#endif
			break;
		case 5: // Contacts
			break;
		default:
			break;
	}
}

- (void)buttonClicked:(NSInteger)num
{
	NSLog(@"buttonClicked method num is %d",num);
	[self showView:_buttonView display:NO animated:YES];
    if (num == 0) // Ignore
    {
    }
    else if (num == 1) // hold call + answer
    {
    }
}

/*** Buttons callback ***/
- (void)phonePad:(id)phonepad appendString:(NSString *)string
{
	NSLog(@"appendString Method %@",string);
	[self showCallNumber: string];
}

- (void)phonePad:(id)phonepad replaceLastDigitWithString:(NSString *)string
{
	NSLog(@"replaceLastDigitWithString Method %@",string);
	[self showCallNumber: string];
}

- (void)showCallNumber:(NSString *)string
{
	if ([_curText length] == 0) {
		_curText = string;
	}else{
		_curText = [_curText stringByAppendingString: string];
		
	}
	[_callTextView setLabel:_curText];
	
}

@end
