//
//  InviteByContact.m
//  Sections
//
//  Created by Adam on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "InviteByContact.h"
#import "ABContentUtil.h"
#import "DataProvider.h"
#import "FCClient.h"
#import "Globe.h"

@implementation InviteByContact

@synthesize names;
@synthesize keys;
@synthesize type;
@synthesize resultContent;
@synthesize resultCell;

- (id)initWithStyle
{
	NSLog(@"InviteByContact::initWithStyle");
    [super init];
    resultCell = [[NSMutableArray alloc] init];
    resultContent = [[NSMutableArray alloc] init];
 	return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"InviteByContact::viewDidLoad start");
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK",nil)
                                                                               style:UIBarButtonItemStyleDone 
                                                                              target:self action:@selector(saveClick:)] autorelease];
    
    self.names = [ABContentUtil selAllABContentInfo:type];
    
    NSArray *array = [[names allKeys] sortedArrayUsingSelector:
                      @selector(compare:)];
    self.keys = array;
    NSLog(@"InviteByContact::viewDidLoad end");
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.names = nil;
    self.keys = nil;
}

- (void)dealloc {
    
    [names release];
    [keys release];
    
    [resultCell release];
    [resultContent release];
    [super dealloc];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    
    return [nameSection count];
}

// change screen
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier ];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:SectionsTableIdentifier] autorelease];
    }
    
    NSArray *tempArray = [[nameSection objectAtIndex:row] componentsSeparatedByString:KSeparatedFlag];
    cell.textLabel.text = [tempArray objectAtIndex:0];
    cell.detailTextLabel.text = [tempArray objectAtIndex:1];
    
    if (![resultCell containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *mCell = [tableView cellForRowAtIndexPath:indexPath];
    if (mCell.accessoryType == UITableViewCellAccessoryNone) {
        mCell.accessoryType = UITableViewCellAccessoryCheckmark;
        //        mCell.textColor = [UIColor blueColor];
        [resultCell addObject:indexPath];
        [resultContent addObject:mCell.detailTextLabel.text];
    }else if (mCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        mCell.accessoryType = UITableViewCellAccessoryNone;
        //        mCell.textColor = [UIColor blueColor];
        int valIndex = [resultCell indexOfObject:indexPath];
        if(valIndex >= 0){
            [resultCell removeObject:indexPath];
        }
        int valContent = [resultContent indexOfObject:mCell.detailTextLabel.text];
        if(valContent >= 0){
            [resultContent removeObject:mCell.detailTextLabel.text];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return keys;
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
    NSLog(@"%d",[resultContent count]);
    NSMutableString *mNSMutableString = [[NSMutableString alloc] init];
    int i;
    for (i=0; i<[resultContent count]; i++) {
        [mNSMutableString appendString:[resultContent objectAtIndex:i]];
        if (i != [resultContent count]-1) {
            [mNSMutableString appendString:@","];
        }
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
    [_dataProvider invitePeople:[NSString stringWithFormat:@"%@%@",url,mNSMutableString] target:self action:@selector(showResultMessage:)];
    [self retain];
    
    [mNSMutableString release];
}

@end