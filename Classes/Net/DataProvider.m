//
//  DataProvider.m
//  iFaceChina
//
//  Created by MobGuang on 10-8-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "DataProvider.h"
#import "GlobalConstants.h"
#import "FileUtils.h"
#import "XMLUtils.h"
#import "FCClient.h"

@interface DataProvider()
+ (void)loadMyClass:(NSManagedObjectContext *)aManagedObjectContext;
- (void)finishLoadPostsFromWebForMyClass:(FCClient *)sender obj:(NSObject *)obj;
- (void)finishLoadPostsFromWebForOneGroup:(FCClient *)sender obj:(NSObject *)obj;
@end

@implementation DataProvider

@synthesize managedObjectContext;

- (id)initWithContext: (NSManagedObjectContext *) aManagedObjContext {
	self = [super init];
	managedObjectContext = aManagedObjContext;
	
	return self;
}

- (void)dealloc {
	
	[super dealloc];
}

/******************* New methods *******************************/
/*
 #pragma mark init data
 - (void)initDataFromDB {
 // load posts for class from db
 [CoreDataUtils loadPostsFromDB:MY_CLASS_TY 
 MOC:managedObjectContext];
 
 // load posts for common interest group
 [CoreDataUtils loadPostsFromDB:PUBLIC_GP_TY 
 MOC:managedObjectContext];
 }
 */

#pragma mark - load recommend item from web

- (void)finishLoadRecommendItemFromWeb:(FCClient *)sender obj:(NSObject *)obj {
	
	if (obj == nil) {
		goto out;
	}
	
	[XMLUtils parserRecommendItemResponseXml:(NSData *)obj 
                               operationType:loadRecommendItemActionType
                                      sender:sender 
                                         MOC:managedObjectContext
                                   traceType:NONE_LOC_TY];
	
	out:
	if (trigger && action) {
		[trigger performSelector:action withObject:sender];
	}
	
	// caller no need to release it
	[self autorelease];
	
}

- (void)triggerLoadRecommendItemForCommentCountFromWeb:(id)aTrigger action:(SEL)anAction isLoadNew:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType maxItemId:(long long)maxItemId maxCommentCount:(NSInteger)maxCommentCount maxCommentTime:(NSTimeInterval)maxCommentTime {
	trigger = aTrigger;
	action = anAction;
	currentTimeline = maxCommentTime;
	loadRecommendItemActionType = SORT_RECOMMEND_BY_COMMENT_COUNT;
    
	client = [[FCClient alloc] initWithTarget:self 
                                       action:@selector(finishLoadRecommendItemFromWeb:obj:)];
    
	[client getRecommendItems:isLoadNew 
                      groupId:groupId 
               resetGroupType:resetGroupType
                    orderType:SORT_RECOMMEND_BY_COMMENT_COUNT 
                    maxItemId:[NSString stringWithFormat:@"%lld", maxItemId] 
               maxCommentTime:maxCommentTime 
              maxCheckinCount:0 
               maxPraiseCount:0
              maxCommentCount:maxCommentCount];
}

#pragma mark - invite people

- (void)finishInvitePeople:(FCClient *)sender obj:(NSData *)obj {
    if (obj == nil) {
		goto out;
	}
	
	[XMLUtils parserInvitePeopleResult:obj sender:sender];
    
	out:
	if (trigger && action) {
		[trigger performSelector:action withObject:sender];
	}
	
	// caller no need to release it
	[self autorelease];
}

- (void)invitePeople:(NSString *)url target:(id)aTrigger action:(SEL)anAction {
    
    trigger = aTrigger;
	action = anAction;
    
	client = [[FCClient alloc] initWithTarget:self 
                                       action:@selector(finishInvitePeople:obj:)];
    
	[client invitePeople:url];
}

@end
