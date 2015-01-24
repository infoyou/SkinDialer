//
//  DataProvider.h
//  iFaceChina
//
//  Created by MobGuang on 10-8-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FCClient;

@interface DataProvider : NSObject {
	NSManagedObjectContext *managedObjectContext;

	
	FCClient *client;
	
	// trigger callback method
	id trigger;
	SEL action;
	
	/* 
	 * Latest or oldest timeline of post on current UI
	 * 
	 * 1. it is start date time when load new post, e.g., 'currentTimeline'(20101017:12:12:12) is latest timeline on UI , if we want to
	 *    load new posts from 20101017:12:12:12 to now(20101019:12:12:12), then 'currentTimeline' is start date time, 20101019:12:12:12
	 *    is end date time;
	 *
	 * 2. it is end date time when load old post, e.g., 'currentTimeline'(20101019:12:12:12) is oldest timeline on UI, if we want to load
	 *    old posts from 20101018:12:12:12 to 20101019:12:12:12, then 'currentTimeline' is end date time, 20101018:12:12:12 is start date
	 * 	  time.
	 */
	NSTimeInterval	currentTimeline;
	long long		currentPostId;
	
	// recommend item releated
	NSInteger		loadRecommendItemActionType;
	NSInteger		currentMaxPraiseCount;
	NSInteger		currentMaxCheckinCount;
	
	//
	NSInteger contentType;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


- (id) initWithContext: (NSManagedObjectContext *) aManagedObjContext;
//+ (void)loadPosts:(NSManagedObjectContext *)aManagedObjectContext member:(Member *)aMember groupType:(NSInteger)groupType;
+ (void)initContentData:(NSManagedObjectContext *)aManagedObjectContext;


#pragma mark load recommend items
- (void)triggerLoadRecommendItemForCommentCountFromWeb:(id)aTrigger action:(SEL)anAction isLoadNew:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType maxItemId:(long long)maxItemId maxCommentCount:(NSInteger)maxCommentCount maxCommentTime:(NSTimeInterval)maxCommentTime;
- (void)triggerLoadRecommendItemForPraiseCountFromWeb:(id)aTrigger action:(SEL)anAction isLoadNew:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType maxItemId:(long long)maxItemId maxPraiseCount:(NSInteger)maxPraiseCount;
- (void)triggerLoadRecommendItemForCheckinCountFromWeb:(id)aTrigger action:(SEL)anAction isLoadNew:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType maxItemId:(long long)maxItemId maxCheckinCount:(NSInteger)maxCheckinCount;
- (void)triggerLoadRecommendItemForCreateTimeFromWeb:(id)aTrigger action:(SEL)anAction isLoadNew:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType maxItemId:(long long)maxItemId maxCommentTime:(NSTimeInterval)maxCommentTime;
- (void)triggerLoadRecommendItemForHoldDateFromWeb:(id)aTrigger 
                                            action:(SEL)anAction 
                                         isLoadNew:(BOOL)isLoadNew
                                           groupId:(NSString *)groupId 
                                    resetGroupType:(NSInteger)resetGroupType 
                                         maxItemId:(long long)maxItemId
                                    maxCommentTime:(NSTimeInterval)maxCommentTime;

#pragma mark load posts from web 
- (void)triggerLoadPostsFromWebForMyClass:(NSTimeInterval)aCurrentTimeline trigger:(id)aTrigger action:(SEL)anAction contentType:(NSInteger)aContentType currentPostId:(long long)aCurrentPostId;

#pragma mark load posts from DB
+ (long long)getLatestPostFromDBForClassId:(long long)classId;

#pragma mark load class groups from web
- (void)triggerLoadGroupsFromWebForMyClass:(id)aTrigger action:(SEL)anAction contentType:(NSInteger)aContentType;
- (void)triggerLoadRecommendAndActGroupsFromWeb:(id)aTrigger action:(SEL)anAction;
- (void)triggerLoadLohasGroupFromWeb:(id)aTrigger action:(SEL)anAction;

#pragma mark - coop groups
- (void)triggerLoadCoopGroupsFromWeb:(id)aTrigger action:(SEL)anAction;

#pragma mark load classes from web
- (void)triggerLoadClassesFromWeb:(id)aTrigger action:(SEL)anAction contentType:(NSInteger)aContentType;

#pragma mark load post for one group
- (void)triggerLoadPostsFromWebForOneGroup:(NSTimeInterval)aCurrentTimeline trigger:(id)aTrigger action:(SEL)anAction contentType:(NSInteger)aContentType groupId:(NSString *)aGroupId currentPostId:(long long)aCurrentPostId setZeroGroupType:(NSInteger)setZeroGroupType;

#pragma mark load trace/happy coordinates from web
- (void)triggerLoadTracePostsFromWeb:(NSString *)userId latidute:(NSString *)latidute longitude:(NSString *)longitude trigger:(id)aTrigger action:(SEL)anAction;
//- (void)triggerLoadTraceHappyPostsFromWeb:(NSString *)userId latidute:(NSString *)latidute longitude:(NSString *)longitude trigger:(id)aTrigger action:(SEL)anAction;
- (void)triggerLoadTraceHappyItemsFromWeb:(NSString *)userId latidute:(NSString *)latidute longitude:(NSString *)longitude trigger:(id)aTrigger action:(SEL)anAction;
- (void)triggerloadCheckinItemsFromWeb:(NSString *)userId 
                              latidute:(NSString *)latidute 
                             longitude:(NSString *)longitude 
                               trigger:(id)aTrigger 
                                action:(SEL)anAction;

#pragma mark load comment from web
- (void)triggerLoadCommentFromWeb:(NSString *)originalPostId trigger:(id)aTrigger action:(SEL)anAction;

#pragma mark load user info from web
- (void)triggerLoadUserInfo:(NSString *)targetUserId trigger:(id)aTrigger action:(SEL)anAction;

#pragma mark load user list for recommend or activity item
- (void)finishLoadPraisedUserList:(FCClient *)sender obj:(NSObject *)obj;

#pragma mark load user list for recommend or activity item
- (void)triggerLoadPraisedUser:(NSString *)itemId trigger:(id)aTrigger action:(SEL)anAction;
- (void)triggerLoadCheckinUser:(NSString *)itemId trigger:(id)aTrigger action:(SEL)anAction;

#pragma mark fetch new item count
- (void)triggerLoadNewItemCount:(id)aTrigger action:(SEL)anAction;

#pragma mark - load checkin items
- (void)triggerloadCheckinItemsFromWeb:(NSString *)userId 
                              latidute:(NSString *)latidute 
                             longitude:(NSString *)longitude 
                               trigger:(id)aTrigger 
                                action:(SEL)anAction;

#pragma mark - load apply needed groups
- (void)triggerLoadApplyNeededGroupsFromWeb:(id)aTrigger 
                                     action:(SEL)anAction 
                                  groupType:(NSInteger)groupType;

#pragma mark - load courses from web
- (void)triggerLoadCourseGroupsFromWeb:(id)aTrigger 
                                action:(SEL)anAction;

- (void)triggerLoadCoursesFromWeb:(id)aTrigger 
                           action:(SEL)anAction 
                          groupId:(NSString *)groupId;

#pragma mark - load discurss group from web
- (void)triggerLoadDiscussGroupsFromWeb:(id)aTrigger 
                                 action:(SEL)anAction;

#pragma mark - invite people
- (void)invitePeople:(NSString *)url target:(id)aTrigger action:(SEL)anAction;
@end
