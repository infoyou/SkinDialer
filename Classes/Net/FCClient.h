//
//  FCClient.h
//  iFaceChina
//
//  Created by MobGuang on 10-8-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCConnection.h"
#import "sqlite3.h"

typedef enum {
	FC_REQUEST_SENT,
	FC_REQUEST_MESSAGES,
	FC_REQUEST_FAVORITE,
	FC_REQUEST_UNFAVORITE,
	FC_REQUEST_REPLIES,
} RequestType;

@interface FCClient : FCConnection {
	
	RequestType request;
	id context;
	SEL action;
	BOOL hasError;
	NSString *errorMsg;
	NSString *errorDetail;
	
}

@property(nonatomic, readonly) RequestType request;
@property(nonatomic, assign) id context;
@property(nonatomic, assign) BOOL hasError;
@property(nonatomic, copy) NSString* errorMsg;
@property(nonatomic, copy) NSString* errorDetail;

- (id)initWithTarget:(id)aDelegate action:(SEL)anAction;
- (void)sendPost:(NSString *)content to:(NSString *)recipientId latitude:(double)latitude longitude:(double)longitude pic:(UIImage*)pic link:(NSString *)link isWithSMS:(BOOL)isWithSMS;
- (void)sendCheckinItem:(NSString *)content to:(NSString *)recipientId latitude:(double)latitude longitude:(double)longitude pic:(UIImage*)pic link:(NSString *)link isWithSMS:(BOOL)isWithSMS;
- (void)sendComment;
- (void)sendRecommendComment:(NSString *)content originalPostId:(NSString *)originalPostId pic:(UIImage *)pic;
- (void)sendFeedback:(NSString *)content;
- (void)uploadNewItem:(NSString *)intro to:(NSString *)recipientId pic:(UIImage*)pic name:(NSString *)name address:(NSString *)address phoneNumber:(NSString *)phoneNumber cityId:(NSString *)cityId latitude:(double)latitude longitude:(double)longitude postId:(NSString *)postId contact:(NSString *)contact syncToSina:(BOOL)syncToSina originalAuthorId:(NSString *)originalAuthorId detailUrl:(NSString *)detailUrl;

#pragma mark user login/signup
- (void)userRegister:(NSString *)username email:(NSString *)email password:(NSString *)password referrer:(NSString *)referrer;
- (void)userLogin:(NSString *)username password:(NSString *)password;

#pragma mark - get updated post
- (void)getUpdatedPost:(long long)postId groupId:(long long)groupId groupType:(NSInteger)groupType;

#pragma mark get posts of people who user follows
- (void)getPostFromMyFollowings:(NSInteger)groupType groupId:(NSString *)groupId startTS:(NSTimeInterval)startTS contentType:(NSInteger)contentType maxPostId:(NSString *)maxPostId setZeroGroupType:(NSInteger)setZeroGroupType;

#pragma mark get recommend items
- (void)getRecommendItems:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType orderType:(NSInteger)orderType maxItemId:(NSString *)maxItemId maxCommentTime:(NSTimeInterval)maxCommentTime maxCheckinCount:(NSInteger)maxCheckinCount maxPraiseCount:(NSInteger)maxPraiseCount maxCommentCount:(NSInteger)maxCommentCount;	

#pragma mark get class groups
- (void)getRecommendAndActGroups;
- (void)getClassGroups;
- (void)getClasses;
- (void)getCoopGroups;
- (void)getLohasGroup;
- (void)getApplyNeededGroups:(NSInteger)groupType;

#pragma mark get trace posts
- (void)getTracePosts:(NSString *)latidute longitude:(NSString *)longitude;
- (void)getTraceHappyPosts:(NSString *)latidute longitude:(NSString *)longitude;
- (void)getTraceHappyItems:(NSString *)latidute longitude:(NSString *)longitude;

- (void)alert;
- (void)alert:(NSString *)detail;

#pragma mark get comments
- (void)getComments:(NSString *)originalPostId;

#pragma mark get user info
- (void)getUserInfo:(NSString *)targetUserId;

#pragma mark update user info
- (void)updateUserInfo:(NSString *)userId passwd:(NSString *)passwd phoneNum:(NSString *)phoneNum email:(NSString *)email industry:(NSString *)industry company:(NSString *)company bio:(NSString *)bio sinaWeibo:(NSString *)sinaWeibo jobTitle:(NSString *)jobTitle department:(NSString *)department city:(NSString *)city;
- (void)updateAvatar:(UIImage *)pic;

#pragma mark load user list for recommend or activity item
- (void)getPraisedUserList:(NSString *)itemId;
//- (void)getCheckinUserList:(NSString *)itemId;

#pragma mark load new item count
- (void)getNewItemCount;

#pragma mark - load checkin items
- (void)getCheckinItems:(NSString *)latidute 
              longitude:(NSString *)longitude;

#pragma mark - course list
- (void)getCourseGroups;
- (void)getCourseWithGroupId:(NSString *)groupId;

#pragma mark - discuss group
- (void)getDiscussGroups;

#pragma mark - invite people

- (void)invitePeople:(NSString *)url;
@end
