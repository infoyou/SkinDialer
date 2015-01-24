//
//  InviteByInput.m
//  SkinDialer
//
//  Created by Adam on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "InviteByInput.h"

@implementation InviteByInput
@synthesize type;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK",nil) 
                                                                               style:UIBarButtonItemStyleDone 
                                                                              target:self action:@selector(saveClick:)] autorelease];

    inputField = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, 290, 30)];
    if ([type intValue] == 0) {
        inputField.keyboardType = UIKeyboardTypePhonePad;
        inputField.placeholder = NSLocalizedString(@"Please Input Mobile", nil);        
    }else
    {
        inputField.keyboardType = UIKeyboardTypeEmailAddress;
        inputField.placeholder = NSLocalizedString(@"Please Input Mail", nil);
    }
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:inputField];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//cancel number input 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	//
	if([inputField isFirstResponder]){
		[inputField resignFirstResponder];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	// the user pressed the "Done" button, so dismiss the keyboard
	[inputField resignFirstResponder];
	return YES;
}

- (void)showResultMessage:(FCClient *)sender {
    if (sender.hasError) {
        NSLog(@"Invite people result: %@", sender.errorMsg);
    } else {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Note",nil) message:[sender.errorMsg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
        [alertView show];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClick:(id)sender
{
    if ([[inputField text] length]==0 || [[inputField text] isEqualToString:@""]) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"请输入值！" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
        [alertView show];
        return;
    }
    
    NSString *url;
    switch  ([type intValue]) {
        case 0:
            url = @"http://weixun.co/ceibsweibo2/phone_controller?action=invite_friends&user_id=1&plat=a&version=1&session=2333&mobile=";
            break;
        case 1:
            url = @"http://weixun.co/ceibsweibo2/phone_controller?action=invite_friends&user_id=1&plat=a&version=1&session=2333&email=";
            break;
    }
    
    _dataProvider = nil;
    _dataProvider = [[DataProvider alloc] initWithContext:nil];
    [_dataProvider invitePeople:[NSString stringWithFormat:@"%@%@",url,[inputField text]] target:self action:@selector(showResultMessage:)];
    [self retain];
}

@end
