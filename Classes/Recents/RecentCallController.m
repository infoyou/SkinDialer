#import <AddressBook/AddressBook.h>
#import <AddressBookUI/ABPersonViewController.h>
#import <AddressBookUI/ABUnknownPersonViewController.h>
#import "SqliteUtil.h"
#import "CallViewController.h"
#import "RecentCallController.h"
#import "RecentCallBean.h"

@implementation RecentCallController
@synthesize _recentCalls, _uiSegmentedControl;

-(IBAction)toggleEdit:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Delete"];
}

- (id)initWithStyle:(UITableViewStyle)style
{
	NSLog(@"RecentViewController::initWithStyle");
	if (self = [super initWithStyle:style]) 
	{    
		self.title = NSLocalizedString(@"RecentCalls", nil);
		self.tabBarItem.title = NSLocalizedString(@"Recents", @"Recents View");
		self.tabBarItem.image = [UIImage imageNamed:@"Recents"];
		
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@"RecentCallController::viewWillAppear");
	[self loadDBData];
}

-(void)loadDBData
{
	if (isMiss) {
		_recentCalls = [SqliteUtil selMissCallBySqlite];
	}else {
		_recentCalls = [SqliteUtil selRecentCallBySqlite];
	}
	[self.tableView reloadData];
}


- (void)viewDidLoad {
	
	NSLog(@"RecentViewController::viewDidLoad");
	
	self.navigationItem.leftBarButtonItem = [self editButtonItem];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithTitle:NSLocalizedString(@"Clear", @"RecentCall")
											   style:UIBarButtonItemStylePlain
											   target:self action:@selector(clearAll:)]
											  autorelease];
	
	_uiSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(80.0f, 8.0f, 160.0f, 30.0f)];
    [_uiSegmentedControl insertSegmentWithTitle:NSLocalizedString(@"All",@"") atIndex:0 animated:YES];
	[_uiSegmentedControl insertSegmentWithTitle:NSLocalizedString(@"Missed",@"") atIndex:1 animated:YES];
	[_uiSegmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	self.navigationItem.titleView = _uiSegmentedControl;
	
    [super viewDidLoad];
}

- (void)dealloc {
    [_uiSegmentedControl release];
    [_recentCalls release];
	[_dateFormatter release];
	[_hourFormatter release];
    [super dealloc];
}

#pragma mark - Table Data Source Methods
//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
} 

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [_recentCalls count];
}

//行缩进
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = [indexPath row];
	return row;
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

// Customize the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	int index = indexPath.row;
	
	static NSString *CellIdentifier = @"Cell";  
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	RecentCallBean *aCall = [_recentCalls objectAtIndex:index];
	NSString * aCallFlag = [aCall T_CallFlag];
	NSLog(@"aCallFlag is %@",aCallFlag);
	
	UILabel *phoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 3, 160, 20)] autorelease];
	phoneNumberLabel.font = [UIFont systemFontOfSize:18];
	phoneNumberLabel.backgroundColor = [UIColor clearColor];
	[phoneNumberLabel setText:aCall.displayName];
	if ([aCallFlag intValue] == 0) {
		phoneNumberLabel.textColor = [UIColor redColor];
	}else {
		phoneNumberLabel.textColor = [UIColor blackColor];
	}
	
	[cell.contentView addSubview:phoneNumberLabel];
	
	UILabel *callDurationLabel = [[[UILabel alloc] initWithFrame:CGRectMake(7, 20, 80, 30)] autorelease];
	callDurationLabel.font = [UIFont boldSystemFontOfSize:12];
	callDurationLabel.backgroundColor = [UIColor clearColor];
	[callDurationLabel setText:aCall.displayCallDuration];
	[cell.contentView addSubview:callDurationLabel];
	
	UIImageView *aCallTypeImage = [[[UIImageView alloc] initWithFrame:CGRectMake(60, 30, 20, 14)] autorelease];
	if ([aCallFlag intValue] == 1) {
		aCallTypeImage.image = [UIImage imageNamed:@"RecentCall1.png"];
	}else if ([aCallFlag intValue] == 2) {
		aCallTypeImage.image = [UIImage imageNamed:@"RecentCall2.png"];
	}
	
	[cell.contentView addSubview:aCallTypeImage];
	
	UILabel *distance_label = [[[UILabel alloc] initWithFrame:CGRectMake(120, 10, 160, 30)] autorelease];
	distance_label.font = [UIFont systemFontOfSize:14];
	distance_label.backgroundColor = [UIColor clearColor];
	
	if ([aCall.T_CallDate timeIntervalSinceNow] > -86400.0)
		[distance_label setText:[self.hourFormatter stringFromDate:aCall.T_CallDate]];
	else 
		[distance_label setText:[self.dateFormatter stringFromDate:aCall.T_CallDate]];
	[cell.contentView addSubview:distance_label];
	
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
	NSLog(@"willSelectRowAtIndexPath");
    return indexPath;
}

#pragma mark - accessoryButtonTapped
-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:( NSIndexPath *)indexPath{
	NSLog(@"accessoryButtonTappedForRowWithIndexPath %d",[indexPath row]);
	int index = [indexPath row];
	ABRecordRef* person = [ABContentUtil selPersonByNumber:[[_recentCalls objectAtIndex:index] T_PhoneNumber]];
	
	if (person) {
		ABPersonViewController  *knownPersonDetail = [[ABPersonViewController alloc] init];
		knownPersonDetail.title = [[_recentCalls objectAtIndex:index] T_PhoneNumber];
		knownPersonDetail.displayedPerson = person;
		[knownPersonDetail setPersonViewDelegate:self];
		[knownPersonDetail setAllowsEditing:NO];
//		[knownPersonDetail setAllowsDeletion:YES];//no suggestion
		[knownPersonDetail setAllowsActions:YES];
		[self.navigationController pushViewController:knownPersonDetail animated:YES];
		[knownPersonDetail release];
		CFRelease(person);
	} else {
		ABRecordRef person = ABPersonCreate();
		ABRecordSetValue(person, kABPersonFirstNameProperty, [[_recentCalls objectAtIndex:index] T_PhoneNumber] , nil);
		
		ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
		ABMultiValueAddValueAndLabel(multiPhone, [[_recentCalls objectAtIndex:index] T_PhoneNumber], kABPersonPhoneMainLabel, NULL);                  
		ABRecordSetValue(person, kABPersonPhoneProperty, multiPhone,nil);
		CFRelease(multiPhone);
		
		ABUnknownPersonViewController *unKnownPersonDetail = [[ABUnknownPersonViewController alloc] init];
		unKnownPersonDetail.unknownPersonViewDelegate = self;
        
        // initialize for create/add
//        unKnownPersonDetail.allowsActions = NO;
        unKnownPersonDetail.allowsAddingToAddressBook = YES;
		
		unKnownPersonDetail.displayedPerson = person;
		unKnownPersonDetail.title = @"Info";
		[self.navigationController pushViewController:unKnownPersonDetail animated:YES];
		[unKnownPersonDetail release];
	}	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int index = [indexPath row];
	NSLog(@"didSelectRowAtIndexPath %d",[indexPath row]);
	// switch to call view
	CallViewController *call = [[CallViewController alloc] init];
	call._callNum = [[_recentCalls objectAtIndex:index] T_PhoneNumber];
	[self presentModalViewController:call animated:YES];
	[call release];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger index = [indexPath row];
	NSLog(@"index is %d",index);
	
	NSString *recordIDStr = [[_recentCalls objectAtIndex:index] T_ID];
	NSLog(@"RecentCallController callID1 is %@", recordIDStr);
	
	[SqliteUtil deleteTableByID:[recordIDStr intValue]];
	[recordIDStr release];
	
	[self._recentCalls removeObjectAtIndex:index];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                     withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Buttons
- (void)clearAll:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self 
													cancelButtonTitle:NSLocalizedString(@"Cancel", nil) 
											   destructiveButtonTitle:NSLocalizedString(@"Clear All Recents", nil) 
													otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// Clear All Recent
	if (buttonIndex == actionSheet.destructiveButtonIndex)
	{
		//		NSLog(@"Clear All Recent");
		[SqliteUtil deleteTable];
		[_recentCalls setArray:nil];
		[self.tableView reloadData];
	}
	
	if (buttonIndex == actionSheet.cancelButtonIndex) {
		//		NSLog(@"Cancel");
	}
}

- (NSDateFormatter *)dateFormatter
{	
	if (_dateFormatter == nil) 
	{
		_dateFormatter = [[NSDateFormatter alloc] init];
		[_dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
		[_dateFormatter setDoesRelativeDateFormatting:YES];
	}
	return _dateFormatter;
}

- (NSDateFormatter *)hourFormatter
{
	if (_hourFormatter == nil)
	{
		_hourFormatter = [[NSDateFormatter alloc] init];
		[_hourFormatter setDateStyle:NSDateFormatterNoStyle];
		[_hourFormatter setTimeStyle:NSDateFormatterShortStyle];
		[_hourFormatter setDoesRelativeDateFormatting:YES];
	}
	return _hourFormatter;
}

-(void)segmentAction:(id) sender
{
    switch([sender selectedSegmentIndex])
    {
		case 0:
            NSLog(@"segmentAction is %d", 0);
			isMiss = NO;
            break;
		case 1:
			NSLog(@"segmentAction is %d", 1);
			isMiss = YES;
            break;
		default:
			NSLog(@"segmentAction is default");
            break;
	}
	[self loadDBData];
}

#pragma mark - ABUnknownPersonViewControllerDelegate method
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownCardViewController didResolveToPerson:(ABRecordRef)person
{
    
}

- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0)
{
    return YES;
}
@end