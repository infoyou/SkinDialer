//
//  Help.h
//  SkinDialer
//
//  Created by Adam on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Help : UIViewController <UIScrollViewDelegate> {
    
  	UIScrollView* scrollView;
	UIPageControl* pageControl;
	
	BOOL pageControlBeingUsed;
}

@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;

- (IBAction)changePage:(id)sender;

@end
