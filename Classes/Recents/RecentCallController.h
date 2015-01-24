#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ABContentUtil.h"

@interface RecentCallController : UITableViewController <ABUnknownPersonViewControllerDelegate, UIActionSheetDelegate, ABPersonViewControllerDelegate> 
{
    
    UISegmentedControl *_uiSegmentedControl;
    
    NSMutableArray *_recentCalls;
	
	NSDateFormatter *_dateFormatter;
	NSDateFormatter *_hourFormatter;
	
	bool isMiss;
}

@property (nonatomic, retain) NSMutableArray *_recentCalls;
@property (nonatomic, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, readonly) NSDateFormatter *hourFormatter;
@property (nonatomic, retain) UISegmentedControl *_uiSegmentedControl;

-(IBAction)toggleEdit:(id)sender;
-(void)loadDBData;

@end
