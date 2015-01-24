//
//  AboutSoft.m
//  SkinDialer
//
//  Created by Adam on 11-7-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AboutSoft.h"
#import "Globe.h"
#import "WebView.h"

@implementation AboutSoft
@synthesize type;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
        self.title = NSLocalizedString(@"About",nil);
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            switch ([type intValue]) {
                case 0:
                {
                    return 4;
                }
                    break;
                case 1:
                {
                    return 3;
                }
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = indexPath.section;
    
	if (section == 0) 
	{
        UIFont *font = [UIFont systemFontOfSize:14];
        NSString *aboutUS = ABOUT_US;
        CGSize size = [aboutUS sizeWithFont:font constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:UILineBreakModeWordWrap];
        return size.height+20; // 10即消息上下的空间，可自由调整  
	}else if(section == 1){
        return 40;
	}
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d,%d", indexPath.section, indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch ([indexPath section]) {
        case 0:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = ABOUT_US;
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
        }
            break;
        case 1:
        {
            switch ([type intValue]) {
                case 0:
                {
                    switch ([indexPath row]) {
                        case 0:
                        {
                            cell.textLabel.text = @"Soft Version:1.3.2";
                            //                    cell.selectionStyle = 
                        }
                            break;
                        case 1:
                        {
                            cell.textLabel.text = @"电话:10086";
                        }
                            break;
                        case 2:
                        {
                            cell.textLabel.text = @"网址:www.weixun.co";
                        }
                            break;
                        case 3:
                        {
                            cell.textLabel.text = @"Wap:wap.baidu.com";
                        }
                            break;
                    }
                }
                    break;
                case 1:
                {
                    switch ([indexPath row]) {
                        case 0:
                        {
                            cell.textLabel.text = @"电话:0512-50190129";
                            //                    cell.selectionStyle = 
                        }
                            break;
                        case 1:
                        {
                            cell.textLabel.text = @"网址:www.weixun.co";
                        }
                            break;
                        case 2:
                        {
                            cell.textLabel.text = @"Wap:wap.baidu.com";
                        }
                            break;
                    }
                    
                }
                    break;
            }
            break;
        }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    switch ([indexPath section]) {
        case 1:
        {
            switch ([type intValue]) {
                case 0:
                {
                    switch ([indexPath row]) {
                        case 1:
                        {
                            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"10086"]];
                            [[UIApplication sharedApplication] openURL:phoneURL];
                        }
                            break;
                        case 2:
                        {
                            WebView *mWebView = [[[WebView alloc] init] autorelease];
                            [mWebView setStrUrl:@"http://www.163.com"];
                            [self.navigationController pushViewController:mWebView
                                                                 animated:YES];
                        }
                            break;
                        case 3:
                        {
                            WebView *mWebView = [[[WebView alloc] init] autorelease];
                            [mWebView setStrUrl:@"http://www.weixun.co"];
                            [self.navigationController pushViewController:mWebView
                                                                 animated:YES];
                            
                        }
                            break;
                    }
                }
                    break;
                case 1:
                {
                    switch ([indexPath row]) {
                        case 0:
                        {
                            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"051250190129"]];
                            [[UIApplication sharedApplication] openURL:phoneURL];
                        }
                            break;
                        case 1:
                        {
                            WebView *mWebView = [[[WebView alloc] init] autorelease];
                            [mWebView setStrUrl:@"http://www.baidu.com"];
                            [self.navigationController pushViewController:mWebView
                                                                 animated:YES];
                        }
                            break;
                        case 2:
                        {
                            WebView *mWebView = [[[WebView alloc] init] autorelease];
                            [mWebView setStrUrl:@"http://www.weixun.co"];
                            [self.navigationController pushViewController:mWebView
                                                                 animated:YES];
                            
                        }
                            break;
                    }
                    
                }
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

@end
