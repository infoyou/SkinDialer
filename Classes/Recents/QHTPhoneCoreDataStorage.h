#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface QHTPhoneCoreDataStorage : NSObject 
{
	NSManagedObjectModel         *managedObjectModel_;
	NSManagedObjectContext       *managedObjectContext_;	    
	NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSManagedObject *)insertNewRecentCallFromDictionary:(NSDictionary *)aDictionary;
- (void)updateManagedObject:(NSManagedObject *)object fromDictionary:(NSDictionary *)aDictionary;

@end
