//
//  ABRootViewController.m
//  Created by on 11-5-10.
//  Copyright 2011 chiefree. All rights reserved.
//

#import "ABRootViewController.h"
#import "ABContentUtil.h"

@implementation ABRootViewController

@synthesize _PersonMsg;

-(void) buttonClicked
{
	return;
}

- (void)viewDidLoad 
{
	[super viewDidLoad];
    
//	[self setAllowsCardEditing:YES];
//  [self setAllowsCancel:NO];
	
#ifdef __IOS_ADD_VIEW__	
	// iosdk，添加其他按钮 	UIView *v = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 30, 30)];
	v.backgroundColor = [UIColor redColor];
	
	NSLog(@"self.navigationBar = %@, self.navigationController.navigationBar = %@", 
		  self.navigationBar, self.navigationController.navigationBar);
	
	[self.navigationBar addSubview: v];
	
	//[self.navigationController.navigationBar addSubview: v];
	
	[v release];
#endif
	
	UIButton *button = [UIButton buttonWithType: UIButtonTypeContactAdd];
	button.center = CGPointMake(40, 40);
	[button addTarget: self action: @selector(buttonClicked) forControlEvents: UIControlEventTouchUpInside];
	
	//[self.navigationBar addSubview: button];
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//	UIBarButtonItem *pBtn = [[UIBarButtonItem alloc] initWithTitle:@"haha" style:UIBarButtonItemStylePlain target:self action:@selector(dd)];
//	[viewController.navigationItem setRightBarButtonItem:pBtn animated:NO];
//	[pBtn release];
//}

- (id)initWithStyle
{
	NSLog(@"InAppSetting::initWithStyle");
	
	self.tabBarItem.image = [UIImage imageNamed:@"settings"];
	self.tabBarItem.title = NSLocalizedString(@"Settings", @"Modify the settings");
	[super init];
	return self;
}

- (void)dealloc {
    [_PersonMsg release];
    [super dealloc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  
{ 
} 

#pragma mark - ABPeoplePickerNavigationControllerDelegate methods 
// Displays the information of a selected person 
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{ 
 
    ABMultiValueRef multi = ABRecordCopyValue(person, property);
    // Set up an NSArray and copy the values in.
    NSArray *theArray = [(id)ABMultiValueCopyArrayOfAllValues(multi) autorelease];
    // Figure out which values we want and store the index.
    const NSUInteger theIndex = ABMultiValueGetIndexForIdentifier(multi, identifier);
    
    int type = 0;
    //person Name
    if (property == kABPersonPhoneProperty){
        NSString *aPhone = [(NSString*)ABMultiValueCopyValueAtIndex(multi, identifier) autorelease];
        _PersonMsg = aPhone;
        type = 1;
    }else if(property == kABPersonEmailProperty){
        NSString *emailAdress = [(NSString*)ABMultiValueCopyValueAtIndex(multi, identifier) autorelease];
        NSLog(@"emailAdress is %@", emailAdress);
        _PersonMsg = emailAdress;
        type = 2;
    }else if(property == kABPersonURLProperty)
    {   
        NSString * strUrlLabel = @"http://";
        NSString *urlStr = [(NSString*)ABMultiValueCopyValueAtIndex(multi, identifier) autorelease];
        NSLog(@"urlStr is %@", urlStr);
        if([[urlStr lowercaseString] hasPrefix:strUrlLabel] == 1)
        {
            _PersonMsg = urlStr;
        }else{
            _PersonMsg = [NSString stringWithFormat:@"http://%@", urlStr];
        }
        
        type = 3;
    }else if(property == kABPersonAddressProperty)
    {
        //Address
        // Set up an NSDictionary to hold the contents of the array.
        NSDictionary *theDict = [theArray objectAtIndex:theIndex];
        // Set up NSStrings to hold keys and values.  First, how many are there?
        const NSUInteger theCount = [theDict count];
        NSString *keys[theCount];
        NSString *values[theCount];
        // Get the keys and values from the CFDictionary.  Note that because
        // we're using the "GetKeysAndValues" function, you don't need to
        // release keys or values.  It's the "Get Rule" and only applies to
        // CoreFoundation objects.
        [theDict getObjects:values andKeys:keys];
        // Set the address label's text.
        NSString *address;
        address = [NSString stringWithFormat:@"%@, %@, %@, %@ %@",
                   [theDict objectForKey:(NSString *)kABPersonAddressStreetKey],
                   [theDict objectForKey:(NSString *)kABPersonAddressCityKey],
                   [theDict objectForKey:(NSString *)kABPersonAddressStateKey],
                   [theDict objectForKey:(NSString *)kABPersonAddressZIPKey],
                   [theDict objectForKey:(NSString *)kABPersonAddressCountryKey]];
        
        NSLog(@"addressStr is %@", address);
        
        NSMutableString *mString = [address mutableCopy];
        [mString replaceOccurrencesOfString:@"(null)" withString:@"" options:NSCaseInsensitiveSearch range:(NSRange){0,[mString length]}];
        _PersonMsg = [ NSString stringWithString: [ mString autorelease ]];
        NSLog(@"_PersonMsg:%@",_PersonMsg);
        
        type = 4;
    }else {
        type = 0;
    }
    
    switch (type) {
        case 1:
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" /*_PersonMsg */
                                                                     delegate:self 
                                                            cancelButtonTitle:NSLocalizedString(@"Cancel",nil) 
                                                       destructiveButtonTitle:nil 
                                                            otherButtonTitles:NSLocalizedString(@"ContactCall",nil),
                                          NSLocalizedString(@"ContactSms",nil), nil];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        }
            break;
        case 2:
        {
            NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", _PersonMsg]];
            NSLog(@"send sms, URL=%@", phoneNumberURL);
            [[UIApplication sharedApplication] openURL:phoneNumberURL];   
        }
            break;
        case 3:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_PersonMsg]];   
        }
            break;
        case 4:
        {
            NSLog(@"_PersonMsg is %@", _PersonMsg);
            NSString *addressText = [NSString stringWithFormat:@"%@", _PersonMsg];   
            NSLog(@"address: %@", addressText);
            addressText = [addressText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  
            NSString *urlText = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@" , addressText]; 
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];   
        }
            break;
        default:
            break;
    }
    
    if(type!=0){
        CFRelease(multi);
    }
    return NO;
} 

- (void)actionSheet:(UIActionSheet *)actionSheet 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) 
	{
		case 0: 
        {
            // switch to call view
            CallViewController *call = [[CallViewController alloc] init];
            call._callNum = _PersonMsg;
            [self presentModalViewController:call animated:YES];
            [call release];	
        }
			break;
        case 1:
        {
        }
            break;
		default:
 			break;
	}
}

// Dismisses the people picker and shows the application when users tap Cancel.  
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker; 
{ 
    [self dismissModalViewControllerAnimated:YES]; 
} 

#pragma mark ABPersonViewControllerDelegate methods 
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property. 
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person  
                    property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue 
{ 
    return YES; 
} 


#pragma mark ABNewPersonViewControllerDelegate methods 
// Dismisses the new-person view controller.  
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person 
{ 
    [self dismissModalViewControllerAnimated:YES]; 
} 


#pragma mark ABUnknownPersonViewControllerDelegate methods 
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact.  
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person 
{ 
    [self dismissModalViewControllerAnimated:YES]; 
} 


// Does not allow users to perform default actions such as emailing a contact, when they select a contact property. 
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person  
                           property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier 
{ 
    return YES; 
} 

@end
