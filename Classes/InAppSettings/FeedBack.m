//
//  FeedBack.m
//  SkinDialer
//
//  Created by Adam on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FeedBack.h"
#import "Globe.h"

@implementation FeedBack

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
        self.title = NSLocalizedString(@"FeedBack",nil);
    }
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Submit",nil) 
                                                                               style:UIBarButtonItemStyleDone 
                                                                              target:self action:@selector(submitClick:)] autorelease];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([indexPath row]) {
        case 0:
        {
            UIFont *font = [UIFont systemFontOfSize:14];
            NSString *aboutUS = FEED_BACK;
            CGSize size = [aboutUS sizeWithFont:font constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:UILineBreakModeWordWrap];
            return size.height+20; // 10即消息上下的空间，可自由调整
        }
            break;
        case 1:
        {
            return 140;
        }
            break;
    }	
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedBackCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0:
        {
            cell.textLabel.text = FEED_BACK;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
        }
            break;
        case 1:
        {
            textView = [[[UITextView alloc] initWithFrame:CGRectMake(10,10,210,15)] autorelease];
            textView.textColor = [UIColor colorWithWhite:0.5 alpha:.5];
            textView.font = [UIFont systemFontOfSize:13.0];
            textView.delegate = self;
            textView.backgroundColor = [UIColor clearColor];
            textView.text = FEED_BACK_PROMPT;
            textView.returnKeyType = UIReturnKeyDefault;
            textView.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
            textView.scrollEnabled = YES;
            
            // this will cause automatic vertical resize when the table is resized
            textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            
            // note: for UITextView, if you don't like autocompletion while typing use:
            textView.autocorrectionType = UITextAutocorrectionTypeNo;
            
            [cell.contentView addSubview:textView];
        }
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
    if ([textView isFirstResponder]) {
        [textView resignFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textArea{
    NSString *temp = FEED_BACK_PROMPT;
	if ([textArea.text isEqualToString: temp]) {
		textArea.textColor =  [UIColor blackColor];
		textArea.text = @"";
	}
}

- (void)textViewDidEndEditing:(UITextView *)textArea{
	if ([textArea.text isEqualToString :@""]) {
		textArea.textColor =  [UIColor colorWithWhite:0.5 alpha:.5];
		textArea.text = FEED_BACK_PROMPT;
	}
}

-(void)submitClick:(id)sender
{
    //submit
    NSString *temp = FEED_BACK_PROMPT;
    if ([textView.text isEqualToString: temp] || [textView.text length] == 0) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Note",nil) 
                                                         message:@"反馈内容不能为空！"
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil] autorelease];
		[alert show];
	}else{
        NSString *url = @"http://weixun.co/ceibsweibo2/phone_controller?action=suggestion_submit&user_id=1&plat=a&version=1.6&message=";
        _dataProvider = nil;
        _dataProvider = [[DataProvider alloc] initWithContext:nil];
        [_dataProvider invitePeople:[NSString stringWithFormat:@"%@%@",url,[textView text]] target:self action:@selector(showResultMessage:)];
        [self retain];
    }
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

- (NSString *)getFeedBackContent{
	return textView.text;
}

@end
