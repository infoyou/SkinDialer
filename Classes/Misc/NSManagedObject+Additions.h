#import <CoreData/CoreData.h>

@interface NSManagedObject (Additions)

- (void)updateValuesFromDictionary:(NSDictionary *)aDictionary;

@end
