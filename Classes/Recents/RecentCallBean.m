#import "RecentCallBean.h"
#import "ABContentUtil.h"

@implementation RecentCallBean

@synthesize T_ID;
@synthesize T_CallFlag;
@synthesize T_PhoneNumber;
@synthesize T_CallDate;
@synthesize T_CallDuration;

@synthesize uid;
@synthesize identifier;
@synthesize displayName;
@synthesize	displayCallDuration;
@synthesize displayCallFlag;

- (NSString *)displayName
{
	if ([self.T_PhoneNumber length])
		return [ABContentUtil selNameByNumberFormApi:self.T_PhoneNumber];
	else
		return NSLocalizedString(@"Unknown", @"Recents View");
}

- (NSString *)displayCallDuration
{
	if ([[self T_CallFlag] intValue] == 0)
		return [NSString stringWithFormat:@"%@", @"00:00"];
	else{
		int intervalTime = [[self T_CallDuration] intValue];
		
//		NSLog(@"intervalTime is %d",intervalTime);
		
		if (intervalTime >= 3600)
		{
			long sec = intervalTime % 3600;
			return [NSString stringWithFormat:@"%d:%02d:%02d",
					intervalTime / 3600,
					sec/60, sec%60];
		}
		else
		{
			return [NSString stringWithFormat:@"%02d:%02d",
					(intervalTime)/60,
					(intervalTime)%60];
		}
		
	}
}

- (NSString *)displayCallFlag
{
	if ([[self T_CallFlag] intValue] == 0)
		return [NSString stringWithFormat:@"%@", @"00:00"];
	else
		return [self T_CallDuration];
}

//- (BOOL) isMissed
//{
//	return ([[self T_CallFlag] intValue] == 0 && [[self T_CallDuration] intValue] == 0);
//}

@end
