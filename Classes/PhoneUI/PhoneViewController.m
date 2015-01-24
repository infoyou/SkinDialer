#import "PhoneViewController.h"
#import "SkinDialerAppDelegate.h"
#import "UIScreen+ConvertRect.h"
#import "CallViewController.h"
#import "ReceiveViewController.h"

static const NSString *forbiddenChars = @",;/?:&=+$";

@interface PhoneViewController ()

- (void)addNewPerson;

@end

@implementation PhoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) 
	{
		// Initialization code
		self.title = NSLocalizedString(@"Keypad", nil);
		self.tabBarItem.image = [UIImage imageNamed:@"Dial"];
		
		_lcd = [[LCDPhoneView alloc] initWithFrame:
				CGRectMake(0.0f, 0.0f, 320.0f, 74.0f)];
		_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
		
#if 0
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processRegState:)
													 name: kSIPRegState 
												   object:nil];
#endif
		
		peoplePickerCtrl = [[ABPeoplePickerNavigationController alloc] init];
		peoplePickerCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
		peoplePickerCtrl.peoplePickerDelegate = self;
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
 */
- (void)loadView 
{  
	UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	//  //[view setBackgroundColor:_color];
	
	_textfield = [[UITextField alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 74.0f)];
	//_textField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
	_textfield.autocorrectionType = UITextAutocorrectionTypeNo;
	_textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_textfield.keyboardType = UIKeyboardTypeURL;
	//  _textfield.returnKeyType = UIReturnKeyDone;
	_textfield.borderStyle = UITextBorderStyleNone;
	_textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_textfield.delegate = self;
	_textfield.textColor = [UIColor lightGrayColor];
	_textfield.backgroundColor = [UIColor clearColor];
	_textfield.font = [UIFont fontWithName:@"Helvetica" size:35];
	_textfield.minimumFontSize = 15;
	_textfield.adjustsFontSizeToFitWidth = YES;
	_textfield.textAlignment = UITextAlignmentCenter;
	_textfield.text = @"";
	
	[_lcd addSubview:_textfield];
	
	_pad = [[DialerPhonePad alloc] initWithFrame: 
			CGRectMake(0.0f, 74.0f, 320.0f, 273.0f)];
	
	[_pad setPlaysSounds:YES];
	/*[_pad setPlaysSounds:[[NSUserDefaults standardUserDefaults] 
	 boolForKey:@"keypadPlaySound"]];*/
	[_pad setDelegate:self];
	
	_addContactButton = [[UIButton alloc] initWithFrame:
                         CGRectMake(0.0f, 0.0f, 107.0f, 64.0f)];
	[_addContactButton setImage: [UIImage imageNamed:@"addcontact"]
                       forState:UIControlStateNormal];
	[_addContactButton setImage: [UIImage imageNamed:@"addcontact_pressed"] 
                       forState:UIControlStateHighlighted];
	[_addContactButton addTarget:self action:@selector(addContactPressed:) 
				forControlEvents:UIControlEventTouchDown];
	
	_callButton =[[UIButton alloc] initWithFrame:
				  CGRectMake(107.0f, 0.0f, 107.0f, 64.0f)];
	_callButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"call"]];
	//_callButton.enabled = NO;
	
	[_callButton setImage:[UIImage imageNamed:@"answer"] 
				 forState: UIControlStateNormal];
	_callButton.imageEdgeInsets = UIEdgeInsetsMake (0., 0., 0., 5.);
	[_callButton setTitle:@"Call" forState:UIControlStateNormal];
	
	[_callButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	[_callButton setTitleShadowColor:[UIColor colorWithWhite:0. alpha:0.2]  forState:UIControlStateDisabled];
	[_callButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[_callButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5]  forState:UIControlStateDisabled];
	
	
	[_callButton addTarget:self action:@selector(callButtonDidPress:) 
		  forControlEvents:UIControlEventTouchDown];
	[_callButton addTarget:self action:@selector(callButtonDidReleaseOutside:) 
		  forControlEvents:UIControlEventTouchUpOutside];
	
	[_callButton addTarget:self action:@selector(callButtonDidReleaseInside:) 
		  forControlEvents:UIControlEventTouchUpInside];
	
	_deleteButton = [[UIButton alloc] initWithFrame:
					 CGRectMake(214.0f, 0.0f, 107.0f, 64.0f)];
	[_deleteButton setImage:[UIImage imageNamed:@"delete"] 
				   forState:UIControlStateNormal];
	[_deleteButton setImage: [UIImage imageNamed:@"delete_pressed"] 
				   forState:UIControlStateHighlighted];
	[_deleteButton addTarget:self action:@selector(deleteButtonPressed:) 
			forControlEvents:UIControlEventTouchDown];
	[_deleteButton addTarget:self action:@selector(deleteButtonReleased:) 
			forControlEvents:UIControlEventValueChanged| 
	 UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
	
	_container = [[UIView alloc] initWithFrame:
				  CGRectMake(0.0f, 347.0f, 320.0f, 64.0f)];
	
	[view addSubview:_lcd];
	[view addSubview:_pad];
	
	[_container addSubview:_addContactButton];
	
	[_container addSubview:_callButton];
	[_container addSubview:_deleteButton];
	
	[view addSubview:_container];
	
	self.view = view;
	[view release];
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad
 */
- (void)viewDidLoad 
{
	[super viewDidLoad];
	_callButton.enabled = NO;
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{ 
	_pad.enabled = NO;
	
	_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
	
	NSDictionary* info = [aNotification userInfo];
	
	// Get the size of the keyboard.
	NSValue* aValue = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardEndFrame = [UIScreen convertRect:[aValue CGRectValue] toView:self.view];
	
	CGRect rect = _container.frame;
	rect.origin.y = keyboardEndFrame.origin.y - 64.0f;
	[UIView animateWithDuration:0.3 animations:^{ _container.frame = rect; }];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
	_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
	
	CGRect rect = _container.frame;
	rect.origin.y = 347.0f;
	
	[UIView animateWithDuration:0.3 animations:^{
		_container.frame = rect;
	} 
					 completion:^(BOOL finished){
						 _pad.enabled = YES;
					 }];
}

- (void)viewWillAppear:(BOOL)animated 
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification 
											   object:nil];
}

- (void)viewWillDisappear:(BOOL)animated 
{
	[_textfield resignFirstResponder];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification 
												  object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification 
												  object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


- (void)dealloc 
{
#if 0
	[[NSNotificationCenter defaultCenter] removeObserver:self name: kSIPRegState object:nil];
#endif
	[peoplePickerCtrl release];
	
	[_textfield release];
	[_lcd release];
	[_pad release];
	
	[_addContactButton release];
	
	[_callButton release];
	
	[_deleteTimer invalidate];
	[_deleteTimer release];
	[_deleteButton release];
	
	[_container release];
	
	[super dealloc];
}

/*** Buttons callback ***/
- (void)phonePad:(id)phonepad appendString:(NSString *)string
{
	//	NSLog(@"appendString Method %@",string);
	NSString *curText = [_textfield text];
	[_textfield setText: [curText stringByAppendingString: string]];
	
	_callButton.enabled = YES;
	_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
}

- (void)phonePad:(id)phonepad replaceLastDigitWithString:(NSString *)string
{
	NSLog(@"replaceLastDigitWithString Method");
	NSString *curText = [_textfield text];
	curText = [curText substringToIndex:([curText length] - 1)];
	[_textfield setText: [curText stringByAppendingString: string]];
}

- (void)callButtonDidLongPress:(NSTimer *)timer
{
	NSLog(@"callButtonDidLongPress ！");
}

- (void)callButtonDidPress:(UIButton *)button
{	
	//	NSLog(@"callButtonDidPress ！");
	if ([[_textfield text] length] > 0)
	{
		NSLog(@"[[_textfield text] length] > 0");
		_callButtonTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(callButtonDidLongPress:) userInfo:button repeats:NO] retain];
	}
	else {
		_callButtonTimer = nil;
	}
	
	// switch to call view
//	CallViewController *call = [[CallViewController alloc] init];
	ReceiveViewController *call = [[ReceiveViewController alloc] init];
	call._callNum = [_textfield text];
	[self presentModalViewController:call animated:YES];
	[call release];
}

- (void)callButtonDidReleaseOutside:(UIButton *)button
{
	NSLog(@"callButtonDidReleaseOutside ！");
	[_callButtonTimer invalidate];
	[_callButtonTimer release];
	_callButtonTimer = nil;
}

- (void)callButtonDidReleaseInside:(UIButton*)button
{
	NSLog(@"callButtonDidReleaseInside ！");
	
	if ([[_textfield text] length] > 0)
	{
		_lastNumber = [[NSString alloc] initWithString: [_textfield text]];
		[_textfield setText:@""];
		_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
		
	}
	else
	{
		_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
		[_textfield setText:_lastNumber];
		[_lastNumber release];
	}
}

- (void)addContactPressed:(UIButton*)unused
{
	NSLog(@"addContactPressed method");
	if ([[_textfield text] length] < 1) 
		return;
	
	if (ABAddressBookGetPersonCount(ABAddressBookCreate ()) == 0)
	{
		[self addNewPerson];
	}
	else
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
																 delegate:self 
														cancelButtonTitle:NSLocalizedString(@"Cancel",nil) 
												   destructiveButtonTitle:nil 
														otherButtonTitles:NSLocalizedString(@"Create New Contact",nil),
									  NSLocalizedString(@"Add to Existing Contact",nil), nil];
		
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
	}
}

- (void)stopTimer
{
	if (_deleteTimer)
	{
		[_deleteTimer invalidate];
		[_deleteTimer release];
		_deleteTimer = nil;
	}
	if ([[_textfield text] length] == 0)
	{
		_callButton.enabled = NO;
		if (!_textfield.editing)
			_lcd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcd_top"]];
	}
}

- (void)deleteRepeat
{
	NSString *curText = [_textfield text];
	int length = [curText length];
	if(length > 0)
	{
		_deletedChar++;
		//	Press 5 times text is null
		if (_deletedChar == 5)
		{
			[_textfield setText:@""];
		}
		else
		{
			[_textfield setText: [curText substringToIndex:(length-1)]];
		}
	}
	else
	{
		[self stopTimer];
	}
}

- (void)deleteButtonPressed:(UIButton*)unused
{
	NSLog(@"deleteButtonPressed Method");
	_deletedChar = 0;
	[self deleteRepeat];
	_deleteTimer = [[NSTimer scheduledTimerWithTimeInterval:0.2 target:self 
												   selector:@selector(deleteRepeat) 
												   userInfo:nil 
													repeats:YES] retain];
}

- (void)deleteButtonReleased:(UIButton*)unused
{
	NSLog(@"deleteButtonReleased Method");
	[self stopTimer];
}

- (void)addNewPerson
{
	CFErrorRef error = NULL;
	// Create New Contact
	ABRecordRef person = ABPersonCreate ();
	
	// Add phone number
	ABMutableMultiValueRef multiValue = ABMultiValueCreateMutable(kABStringPropertyType);
	
	ABMultiValueAddValueAndLabel(multiValue, [_textfield text], kABPersonPhoneMainLabel, NULL);  
	
	ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
	
	
	ABNewPersonViewController *newPersonCtrl = [[ABNewPersonViewController alloc] init];
	newPersonCtrl.newPersonViewDelegate = self;
	newPersonCtrl.displayedPerson = person;
	CFRelease(person); // TODO check
	
	UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:newPersonCtrl];
	navCtrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[self.parentViewController presentModalViewController:navCtrl animated:YES];
	[newPersonCtrl release];
	[navCtrl release];
}

#pragma mark -
#pragma mark ABNewPersonViewControllerDelegate
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController 
       didCompleteWithNewPerson:(ABRecordRef)person
{
	[newPersonViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	CFErrorRef error = NULL;
	BOOL status;
	ABMutableMultiValueRef multiValue;
	// Inserer le numéro dans la fiche de la personne
	// Add phone number
	CFTypeRef typeRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
	if (ABMultiValueGetCount(typeRef) == 0)
		multiValue = ABMultiValueCreateMutable(kABStringPropertyType);
	else
		multiValue = ABMultiValueCreateMutableCopy (typeRef);
	
	// TODO type (mobile, main...)
	// TODO manage URI
	status = ABMultiValueAddValueAndLabel(multiValue, [_textfield text], kABPersonPhoneMainLabel, 
										  NULL);  
	
	status = ABRecordSetValue(person, kABPersonPhoneProperty, multiValue, &error);
	status = ABAddressBookSave(peoplePicker.addressBook, &error);
	[peoplePicker dismissModalViewControllerAnimated:YES];
	return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[peoplePicker dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) 
	{
		case 0: // Create new contact
			[self addNewPerson];
			break;
		case 1: // Add to existing Contact
			[self presentModalViewController:peoplePickerCtrl animated:YES];
			break;
		default:
			break;
	}
}

#if 0
- (void)cancelAddPerson:(id)unused
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}
#endif

- (void)reachabilityChanged:(NSNotification *)notification
{
	[_lcd rightText:@"Service Unavailable"];
}

#if 0
- (void)processRegState:(NSNotification *)notification
{
	//pjsua_acc_info info;
	//pjsua_acc_id acc_id;
	//NSString *status;
	//acc_id = [[[ notification userInfo ] objectForKey: @"AccountID"] intValue];
	NSDictionary *dictionary = [notification userInfo];
	if ([[dictionary objectForKey:@"Status"] intValue] == 200)
		[_lcd rightText:@"Connected"];
	else
		[_lcd rightText:[dictionary objectForKey:@"StatusText"]];
}
#endif

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[_textfield setText:@""];
	_callButton.enabled = NO;
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSRange r = [forbiddenChars rangeOfString: string];
	if (r.location != NSNotFound)
		return NO;
	
	_callButton.enabled = ([[textField text] length] + [string length] - range.length > 0);
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	// return ([[textField text] length] == 0);
	return NO;
}

@end
