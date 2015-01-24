//
//  InviteByContact.h
//  Sections
//
//  Created by Adam on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataProvider;
@interface InviteByContact : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *names;
    NSArray     *keys;
    
    NSString *type;
    NSMutableArray *resultCell;
    NSMutableArray *resultContent;	
    
    DataProvider *_dataProvider;
}

@property (nonatomic, retain) NSDictionary *names;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSMutableArray *resultCell;
@property (nonatomic, retain) NSMutableArray *resultContent;

- (id)initWithStyle;

@end

