//
//  FeedBack.h
//  SkinDialer
//
//  Created by Adam on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "FCClient.h"

@class DataProvider;

@interface FeedBack : UITableViewController <UITextViewDelegate>
{
    
    UITextView *textView;
    DataProvider *_dataProvider;
}

@end
