#import "NSManagedObject+Additions.h"


@implementation NSManagedObject (Additions)

- (void)updateValuesFromDictionary:(NSDictionary *)aDictionary
{
	for(NSString *key in [aDictionary allKeys])
	{
		[self setValue:[aDictionary valueForKey:key] forKey:key];
	}
}

@end
