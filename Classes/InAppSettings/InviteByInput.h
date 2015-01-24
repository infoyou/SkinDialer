//
//  InviteByInput.h
//  SkinDialer
//
//  Created by Adam on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "FCClient.h"

@class DataProvider;

@interface InviteByInput : UIViewController {
    
    NSString *type;
    UITextField *inputField;
    DataProvider *_dataProvider;
}

@property (nonatomic, retain) NSString *type;

@end
