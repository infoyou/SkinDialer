//
//  AppSettings.m
//  SkinDialer
//
//  Created by Adam on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppSettings.h"
#import "BindingSNS.h"
#import "InviteFriend.h"
#import "Help.h"
#import "FeedBack.h"
#import "AboutSoft.h"
#import "SkinDialerAppDelegate.h"

@implementation AppSettings

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
        self.tabBarItem.title = NSLocalizedString(@"Setting", nil);
    }
    return self;
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.title) {
        self.title = NSLocalizedString(@"More",nil);
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) 
	{
		return 3;
	}
	else if (section == 1) 
	{
		return 3;
	}
	else if(section == 2)
	{
		return 1;
	}
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
    switch ([indexPath section]) {
        case 0:
            if (row == 0) {
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.textLabel.text = NSLocalizedString(@"SNS",nil);
				
            }
            else if(row == 1)
			{
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.textLabel.text = NSLocalizedString(@"Invite Friends",nil);
				
			}
            else if(row == 2)
			{
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.textLabel.text = NSLocalizedString(@"Help",nil);
				
			}
            break;
        case 1:
            if (row == 0) {
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.textLabel.text = NSLocalizedString(@"FeedBack",nil);
				
            }
            else if(row == 1)
			{
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.textLabel.text = NSLocalizedString(@"About",nil);
				
			}
            else if(row == 2)
			{
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.textLabel.text = NSLocalizedString(@"WeiXun",nil);
				
			}
            break;   
        case 2:
            if (row == 0) {
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.textLabel.text = NSLocalizedString(@"LogOut",nil);
				
            }
            break;
        default:
            break;
    }
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                NSLog(@"Binding SNS");
                BindingSNS *mBindingSNS = [[BindingSNS alloc] initWithStyle:UITableViewStyleGrouped];
                [self.navigationController pushViewController:mBindingSNS
                                                     animated:YES];
            }else if (indexPath.row == 1) {
                NSLog(@"Invite Friend");
                InviteFriend *mInviteFriend = [[[InviteFriend alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
                [self.navigationController pushViewController:mInviteFriend
                                                     animated:YES];
            }else if(indexPath.row == 2){
                NSLog(@"Help");
                Help *mHelp = [[[Help alloc] init] autorelease];
                [self.navigationController pushViewController:mHelp animated:YES];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                NSLog(@"User FeedBack");
                FeedBack *mFeedBack = [[[FeedBack alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
                [self.navigationController pushViewController:mFeedBack
                                                     animated:YES];
            }else if (indexPath.row == 1) {
                NSLog(@"About Soft");
                AboutSoft *mAboutSoft = [[[AboutSoft alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
                [mAboutSoft setType:@"0"];
                [self.navigationController pushViewController:mAboutSoft
                                                     animated:YES];
            }else if (indexPath.row == 2) {
                NSLog(@"About WeiXun");
                AboutSoft *mAboutSoft = [[[AboutSoft alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
                [mAboutSoft setType:@"1"];
                [self.navigationController pushViewController:mAboutSoft
                                                     animated:YES];
            }
            
        }
            break;
        case 2:
        {
        }
            break;
        default:
            break;
    }
    
}

@end
