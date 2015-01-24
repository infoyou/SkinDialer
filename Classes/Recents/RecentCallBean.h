#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

//RecentCall Bean
@interface RecentCallBean : NSObject
{
	NSString *T_ID;
	NSString *T_PhoneNumber;
	NSDate   *T_CallDate;
	NSString *T_CallFlag; /* 0=Reject; 1=Call; 2=Receive */
	NSString *T_CallDuration;
}
 

// Base Properties
@property (nonatomic, retain)  NSString *T_ID;
@property (nonatomic, retain)  NSString *T_PhoneNumber;
@property (nonatomic, retain)  NSDate   *T_CallDate;
@property (nonatomic, retain)  NSString *T_CallFlag;
@property (nonatomic, retain)  NSString *T_CallDuration;

@property (nonatomic, assign)  NSNumber *uid; /*ABRecordID*/
@property (nonatomic, assign)  NSNumber *identifier; /* ABMultiValueIdentifier */

// Computed Properties
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) NSString *displayCallDuration;
@property (nonatomic, retain) NSString *displayCallFlag;



@end
