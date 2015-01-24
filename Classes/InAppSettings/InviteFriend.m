//
//  InviteFriend.m
//  SkinDialer
//
//  Created by Adam on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "InviteFriend.h"
#import "InviteByContact.h"
#import "InviteByInput.h"

@implementation InviteFriend

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
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
    
    if(!self.title){
        self.title = NSLocalizedString(@"Invite Friends",nil);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0:
        {
            cell.textLabel.text = NSLocalizedString(@"Invite by mobile From Contacts",nil);            
        }
            break;
        case 1:
        {
            cell.textLabel.text = NSLocalizedString(@"Invite by mail From Contacts",nil); 
        }
            break;
        case 2:
        {
            cell.textLabel.text = NSLocalizedString(@"Invite by mobile",nil); 
        }
            break;
        case 3:
        {
            cell.textLabel.text = NSLocalizedString(@"Invite by mail",nil); 
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
     
    switch ([indexPath row]) {
        case 0:
        {
            InviteByContact *mInviteByContact = [[[InviteByContact alloc] initWithStyle] autorelease];
            [mInviteByContact setType:@"0"];
            [self.navigationController pushViewController:mInviteByContact animated:YES];
        }
            break;
        case 1:
        {
            InviteByContact *mInviteByContact = [[[InviteByContact alloc] initWithStyle] autorelease];
            [mInviteByContact setType:@"1"];
            [self.navigationController pushViewController:mInviteByContact animated:YES];        
        }
            break; 
        case 2:
        {
            InviteByInput *mInviteByInput = [[[InviteByInput alloc]init] autorelease];
            [mInviteByInput setType:@"0"];
            [self.navigationController pushViewController:mInviteByInput animated:YES];
        }
            break;
        case 3:
        {
            InviteByInput *mInviteByInput = [[[InviteByInput alloc]init] autorelease];
            [mInviteByInput setType:@"1"];
            [self.navigationController pushViewController:mInviteByInput animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
