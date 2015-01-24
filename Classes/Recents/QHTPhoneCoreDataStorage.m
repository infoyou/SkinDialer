#import "QHTPhoneCoreDataStorage.h"
#import <UIKit/UIKit.h>

#import "NSManagedObject+Additions.h"


@implementation QHTPhoneCoreDataStorage

#pragma mark -
#pragma mark Core Data stack

- (NSString *)applicationDocumentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *result = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if(![fileManager fileExistsAtPath:result])
		[fileManager createDirectoryAtPath:result withIntermediateDirectories:YES attributes:nil error:nil];
	
	return result;
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext 
{	

	if (managedObjectContext_ == nil) 
	{
		NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
		if (coordinator != nil) 
		{
			managedObjectContext_ = [[NSManagedObjectContext alloc] init];
			[managedObjectContext_ setPersistentStoreCoordinator: coordinator];
		}
	}
	return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models 
 found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel 
{	
	/*
	if (managedObjectModel_ == nil)
	{
		managedObjectModel_ = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	}
	return managedObjectModel_;
	 */
	return nil;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
	/*
	if (persistentStoreCoordinator_ == nil) 
	{
		NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"CoreDataQHTPhone.sqlite"];
		//Set up the store.
		// For the sake of illustration, provide a pre-populated default store.
		 
		NSFileManager *fileManager = [NSFileManager defaultManager];
		// If the expected store doesn't exist, copy the default store.
		if (![fileManager fileExistsAtPath:storePath]) 
		{
			NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"CoreDataQHTPhone" ofType:@"sqlite"];
			if (defaultStorePath) 
			{
				[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
			}
		}
		
		NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
		
		NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];	
		persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
		
		NSError *error;
		if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType 
																									 configuration:nil 
																														 URL:storeUrl 
																												 options:options 
																													 error:&error]) 
		{
			// Update to handle the error appropriately.
			//NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			//exit(-1);  // Fail
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Fatal database error", @"Fatal database error")
																											message:[NSString stringWithFormat:NSLocalizedString(@"Unable to initialize database: %@", @"Unable to initialize database"), [error localizedDescription]]
																										 delegate:nil
																						cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
																						otherButtonTitles:nil];
			[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
			[alert release];
		} 
	}
	
	return persistentStoreCoordinator_;
	*/
	
	return nil;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{	
	/*
	[managedObjectContext_ release];
	[managedObjectModel_ release];
	[persistentStoreCoordinator_ release];

	[super dealloc];
	 */
}

#pragma mark -

- (NSManagedObject *)insertNewRecentCallFromDictionary:(NSDictionary *)aDictionary
{
	NSManagedObject *managedObject = [NSEntityDescription
																		insertNewObjectForEntityForName:@"RecentCall"
																		inManagedObjectContext:[self managedObjectContext]];
	[self updateManagedObject:managedObject fromDictionary:aDictionary];
	
	return [managedObject retain];
}

- (void)updateManagedObject:(NSManagedObject *)object fromDictionary:(NSDictionary *)aDictionary
{
	[object updateValuesFromDictionary:aDictionary];

	NSError *error = nil;
	if (![[self managedObjectContext] save:&error])
	{
		NSLog(@"Unresolved error %@, %@", [error localizedDescription], [error localizedRecoverySuggestion]);
		[error release];
	}
}

@end
