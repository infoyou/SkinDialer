//
//  WebView.m
//  SkinDialer
//
//  Created by Adam on 11-7-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WebView.h"


@implementation WebView
@synthesize strUrl;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)dealloc
{
    [strUrl release];
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
    
    if(!self.title){
        self.title = NSLocalizedString(@"About",nil);
    }
    
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 480.0);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    [webView setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:requestObj];
    [self.view addSubview:webView];
    [webView release];
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

@end
