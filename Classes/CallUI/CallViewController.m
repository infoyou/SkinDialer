#import "CallViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AddressBook/AddressBook.h>
#import "BottomBar.h"

#define HOLD_ON 1
#define CYDIA 0
#define kTransitionDuration	0.5

@interface CallViewController (private)

- (void)setSpeakerPhoneEnabled:(BOOL)enable;
- (void)setMute:(BOOL)enable;

@end

@implementation CallViewController

@synthesize _callNum;
@synthesize _fromIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	NSLog(@"CallViewController::initWithNibName");
	return self;
}

- (void)loadView
{
	NSLog(@"CallViewController::loadView");
	
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
	
	// create the container view which we will use for transition animation (centered horizontally)
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
	
	[_menuView setTitle:NSLocalizedString(@"mute", nil)
				  image:[UIImage imageNamed:@"mute.png"] forPosition:0];
	[_menuView setTitle:NSLocalizedString(@"keypad", nil)
				  image:[UIImage imageNamed:@"dialer.png"] forPosition:1];
	[_menuView setTitle:NSLocalizedString(@"speaker", nil)
				  image:[UIImage imageNamed:@"speaker.png"] forPosition:2];
	//  [_menuView setTitle:NSLocalizedString(@"add call", nil)
	//               image:[UIImage imageNamed:@"addcall.png"] forPosition:3];
	
	
#if HOLD_ON
	[_menuView setTitle:NSLocalizedString(@"hold", nil)
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
    //	[_buttonView setTitle:NSLocalizedString(@"Ignore", nil) image:nil forPosition:0];
    //	[_buttonView setTitle:NSLocalizedString(@"Hold Call + Answer", nil) image:nil forPosition:1];
    //	[view addSubview:_buttonView];
    //	
    //	_bottomBar = [[BottomButtonBar alloc] initForIncomingCallWaiting];
    //	[[_bottomBar button] addTarget:self action:@selector(endCallAndAnswer:)
    //				  forControlEvents:UIControlEventTouchUpInside];
	
	/** Title **/
	_callTextView = [[LCDView alloc] initWithDefaultSize];
	
	[_callTextView setLabel:[ABContentUtil selNameByNumber:_callNum]]; // name or number of callee
	[_callTextView setText:NSLocalizedString(@"calling", nil)];   // timer, call state for example
	[view addSubview: _callTextView];
	
	// endCallButton
	_endCallButton = [[BottomDualButtonBar alloc] initForEndCall];	
	[[_endCallButton button] addTarget:self action:@selector(endCall)
					  forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:_endCallButton];
	
	//	hideButton
	UIImage *buttonBackground = [UIImage imageNamed:@"bottombarblue.png"];
	UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombarblue_pressed.png"];
	
	_hideButton = [BottomButtonBar createButtonWithTitle:NSLocalizedString(@"Hide Keypad", nil)
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
	
	self.view = view;
	[view release];
	
}

- (void) viewDidLoad
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(callTime) userInfo:nil repeats:YES];
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
	[_endCallLongButton release];
	[_dualBottomBar release];
	[_callNum release];
    [_fromIndex release];
    
	[_keyPad release];
	[_menuView release];
	[_switchViews[0] release];
	[_switchViews[1] release];
	[_containerView release];
	[_curText release];
	[_callTextView release];
	
#if defined(ONECALL) && (ONECALL == 1)
#else
	[_bottomBar release];
	[_buttonView release];
#endif
	
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
		_endCallLongButton.hidden = YES;
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
	NSLog(@"CallViewController::hideKeypad");
	[self showKeypad:NO animated:YES];
	_endCallLongButton.hidden = NO;
	_endCallButton.hidden = YES;
	_hideButton.hidden = YES;
}

#if defined(ONECALL) && (ONECALL == 1)
#else
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
#endif

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
	RecentCallBean *mRecentCallBean = [[RecentCallBean alloc] init];
	mRecentCallBean.T_PhoneNumber = _callNum;
	mRecentCallBean.T_CallDate = [NSDate date];
	mRecentCallBean.T_CallDuration = [NSString stringWithFormat:@"%d", intervalTime];
	mRecentCallBean.T_CallFlag = [NSString stringWithFormat:@"%d", 1];
	[SqliteUtil insertDB:mRecentCallBean];
	[mRecentCallBean release];
    _callNum = nil;
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

/* Find Name by Number*/
- (ABRecordRef)findRecord:(NSString *)phoneNumber
{
	if (phoneNumber == nil)
		return nil;
	
	//ABCGetSharedAddressBook();
	ABAddressBookRef addressBook = ABAddressBookCreate();
	// ABAddressBookFindPersonMatchingPhoneNumber
	ABRecordRef record = ABCFindPersonMatchingPhoneNumber(addressBook, phoneNumber, 0, 0);
	
	//if (!record)
	//{
	//record = ABAddressBookFindPersonMatchingURL(addressBook, phoneNumber);
	//record = ABCFindPersonMatchingURL(addressBook, phoneNumber, 0, 0);
	//}
	
	//CFRelease(addressBook);
	
	return record;
}

- (UIImage *)findImageWithRecord:(ABRecordRef)record
{
	UIImage *image = nil;
	
	if (record && ABPersonHasImageData(record))
	{
		CFDataRef data;
		
		data = ABPersonCopyImageData(record);
		if (data)
			image = [[UIImage alloc] initWithData: (NSData *)data /*cache:YES*/];
	}
	return image;
}

- (UIImage *)findImageWithRecordID:(ABRecordID) uid
{
	if (uid == kABRecordInvalidID)
		return nil;
	ABAddressBookRef addressBook = ABAddressBookCreate();
	ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, uid);
	UIImage *image = [self findImageWithRecord:record];
	CFRelease(addressBook);
	return image;
}

#if 0
- (void)displayUserInfo:(pjsua_call_id) call_id
{
	pjsua_call_info ci;
	pjsip_name_addr *url;
	pjsip_sip_uri *sip_uri;
	pj_str_t tmp, dst;
	pj_pool_t     *pool;
	
	pool = pjsua_pool_create("call", 128, 128);
	
	if (pool)
	{
		pjsua_call_get_info(call_id, &ci);
		pj_strdup_with_null(pool, &tmp, &ci.remote_info);
		
		url = (pjsip_name_addr*)pjsip_parse_uri(pool, tmp.ptr, tmp.slen,
												PJSIP_PARSE_URI_AS_NAMEADDR);
		if (url != NULL)
		{
			NSString *phoneNumber = NULL;
			sip_uri = (pjsip_sip_uri*) pjsip_uri_get_uri(url->uri);
			pj_strdup_with_null(pool, &dst, &sip_uri->user);
			
			ABRecordRef record = [self findRecord:[NSString stringWithUTF8String:
												   pj_strbuf(&dst)]];
			if (record)
				phoneNumber = (NSString *)ABRecordCopyCompositeName(record);
			if (!phoneNumber)
			{
				if (url->display.slen)
				{
					pj_strdup_with_null(pool, &dst, &url->display);
				}
				phoneNumber = [NSString stringWithUTF8String: pj_strbuf(&dst)];
			}
			[_callTextView setText: phoneNumber];
			UIImage *image = [self findImage: record];
			[_callTextView setSubImage: image];
		}
		else
		{
			[_callTextView setText: @""];
			[_callTextView setSubImage: nil];
		}
		
		pj_pool_release(pool);
	}
}
#endif

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

- (void)endCallAndAnswer
{
	NSLog(@"endCallAndAnswer method");
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
	[self showCallNumber:string];
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
