//
//  Help.m
//  SkinDialer
//
//  Created by Adam on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Help.h"

@implementation Help

@synthesize scrollView, pageControl;

const CGFloat kScrollObjHeight	= 420.0;
const CGFloat kScrollObjWidth	= 320.0;
const NSUInteger kNumImages		= 3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
    pageControlBeingUsed = NO;
    
    // Custom initialization
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScrollObjWidth, kScrollObjHeight)];
    scrollView.directionalLockEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumImages,  scrollView.frame.size.height);
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
 
    
    for (int i = 0; i < kNumImages; i++) {
		CGRect frame;
        frame = scrollView.frame;
        
		frame.origin.x = frame.size.width * i;
		frame.origin.y = 0;
		frame.size = self.scrollView.frame.size;
          
        //        NSString *imageName = [NSString stringWithFormat:@"%d.PNG", i];
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, kScrollObjWidth, kScrollObjHeight);
//		imageView.tag = i;
        
        UIView *subview = [[[UIView alloc] initWithFrame:frame] autorelease];
        subview.frame = frame;
        [subview addSubview:imageView];
		[scrollView addSubview:subview];
        [imageView release];
	}

    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0, 381, kScrollObjWidth, 39)];
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.view addSubview:pageControl];
    	
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = kNumImages;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = sender.frame.size.width;

		int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;   
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//	pageControlBeingUsed = NO;
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    pageControl.currentPage = index;

    //index为当前页码
//    NSLog(@"%d",index);
}

- (IBAction)changePage:(id)sender
{
//    int page = pageControl.currentPage;
//	
//	// update the scroll view to the appropriate page
//    CGRect frame = scrollView.frame;
//    frame.origin.x = frame.size.width * page;
//    frame.origin.y = 0;
//    [scrollView scrollRectToVisible:frame animated:YES];
//    
//	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
//    pageControlBeingUsed = YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	scrollView = nil;
	self.pageControl = nil;
}

- (void)dealloc {
	[scrollView release];
	[pageControl release];
    [super dealloc];
}

@end
