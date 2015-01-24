//
//  GlobalConstants.h
//  iFaceChina
//
//  Created by MobGuang on 10-8-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark -
#pragma mark enum type definition

typedef enum {
  LOGIN_SUCCESS = 0,
  LOGIN_FAILED,
  USER_INACTIVE,
}LoginRes;

typedef enum {
  DEFAULT_SORT_TY = 0,
} PostListSortType;

// post sort type
typedef enum {
  CREATED_AT_SORT_TY = 0,
  LIKE_COUNT_SORT_TY,
  COMMENT_AT_SORT_TY,
  COMMENT_COUNT_SORT_TY,
  HOT_SORT_TY,
} PostSortType;

// tab items
typedef enum {
	TAB_SUB_NEWS,
	TAB_MY_GROUP,
	TAB_MESSAGES,
	TAB_FAVORITES,
	TAB_MORE,
} TabBarItems;

// Operation type
typedef enum {
	LOGIN_SRC,
	SIGNUP_SRC,
	CLASS_SRC,
	LOAD_CLASS_GROUP_SRC,
	LOAD_CLASS_SRC,
	GROUP_SRC,
	GUIDE_SRC,
	SEND_NEW_SRC,
	HOME_LOC_SRC,
	COMPANY_LOC_SRC,
	TRACE_SRC,
	JOIN_ACTION_SRC,
	SEND_COMMENT_SRC,
	FETCH_COMMENT_SRC,
	SEND_FEEDBACK_SRC,
	FETCH_USERINFO_SRC,
	UPDATE_USERINFO_SRC,
	UPDATE_AVATAR_SRC,
	DB_SRC,
	LOAD_LOHAS_CHECKIN_GROUP_SRC,
	LOAD_RECOMMEND_ITEM_SRC,
	LOAD_RECOMMEND_CITY_SRC,
	PRAISE_SRC,
	CHECKIN_SRC,
	ADD_RECOMMEND_ITEM_SRC,
	LOAD_QA_GROUP_SRC,
	SEND_RECOMMEND_COMMENT_SRC,
	FETCH_PRAISED_USERLIST,
	FETCH_CHECKIN_USERLIST,
	UPLOAD_LOC_SRC,
	LOAD_NEW_ITEM_COUNT_SRC,
  LOAD_COOP_GROUPS_SRC,
  LOAD_COURSE_GROUP_SRC,
  LOAD_DISCUSS_GROUP_SRC,
  LOAD_CHECKIN_ITEM_SRC,
  LOAD_APPLYED_GROUPS_SRC,
  LOAD_UPDATED_POST_SRC,
} OperationSourceType;

// switch operation type
typedef enum {
  SWITCH_COMMUNITY,
	SWITCH_CLASS,
	SWITCH_CITY,
	SELECT_CITY_FOR_SEARCH,
  SELECT_SORT_OPTION,
} SwitchActionType;

// location action purpose
typedef enum {
	LOCATE_CURRENT_PLACE,
	LOCATE_CURRENT_CITY,
} LocateActionType;

// reset group type
typedef enum {
	RESET_POST		= 1,
	RESET_ACTIVITY	= 3,
	RESET_RECOMMEND = 4,
	RESET_QA		= 5,
} ResetGroupType;

// owner of take photo action sheet 
typedef enum {
	PHOTO_BTN,
	CLOSE_BTN,
	CALL_BTN,
} ACTION_SHEET_OWNER;

typedef enum {
  NONE_LOC_TY = 0,
	TRACE_TY,
	USER_LOC_TY,
  HAPPY_ITEM_LOC_TY,
  CHECKIN_LOC_TY,
} FCAnnotationType;

enum {
  INVALIDE_PLATFORM_TY = 0,
  ALUMNI_PLATFORM_TY = 1,
  MANAGEMENT_PLATFORM_TY,
} CommunityType;

// group type
enum {
	NEWS_TY = 0,					
	PUBLIC_GP_TY,                       // common group, e.g., interest group in class or school
	MY_CLASS_TY,                        // every customer can only join one this group
	ACTIVITY_GP_TY,                     // activity group
	LOHAS_GP_TY,                        // lohas group
	QA_GP_TY,                           // question and answer group
  CHECKIN_GP_TY,                      // alumnus checkin group
  PRO_ASSOC_GP_TY,                    // professional association
	RECOMMEND_AND_ACT_GP_TY,            // mix group type for recommend and activity
  COMPANY_GP_TY,                      // company group type
  CLASS_MANAGEMENT_GP_TY = 99,        // class management type
  TEAM_COOP_GP_TY = 200,              // team coop group type
  DISCUSS_GP_TY = 201,                // discuss group type
  ENTERPRISE_COLLEGE_GP_TY = 202,     // enterprise college group type
  CHANNEL_MANAGEMEN_GP_TY = 203,      // channel interaction group type
  PUBLIC_OPINION_MONITOR_GP_TY = 204, // public opinion monitor group type
};

// profile related
typedef enum {
	CHG_PASSWD_TY,
	CHG_PHONE_TY,
	CHG_EMAIL_TY,
	CHG_INDUSTRY_TY,
	CHG_COMPANY_TY,
	CHG_BIO_TY,
	CHG_SINA_WEIBO_TY,
  CHG_ITEM_INFO_TY,
  CHG_JOB_TITLE,
  CHG_DEPART,
  CHG_CITY,
} ChangeInfoType;

// recommend related
typedef enum {
	ACTIVITY_ITEM_TY = 1,
	RECOMMEND_ITEM_TY,
  COOP_ITEM_TY,
  COURSE_ITEM_TY,
  DISCUSS_ITEM_TY,
} ItemType;

typedef enum {
	SORT_RECOMMEND_BY_ID = 1,
	SORT_RECOMMEND_BY_COMMENT_TIME,
	SORT_RECOMMEND_BY_CHECKIN_COUNT,
	SORT_RECOMMEND_BY_PRAISE_COUNT,
  SORT_RECOMMEND_BY_CREATE_TIME,
  SORT_RECOMMEND_BY_COMMENT_COUNT,
  SORT_RECOMMEND_BY_HOLD_DATE,
} RecommendSortType;

typedef enum {
	PRAISE_STATUS_ERROR = -2,
	UNPRAISED			= -1,
	CANCEL_PRAISE		= 0,
	PRAISED				= 1,
} PraiseResultType;

typedef enum {
	CHECKIN_STATUS_ERROR = -1,
	CHECKEDIN,
	NOTCHECKEDIN,
} CheckinResultType;

typedef enum {
	PRAISED_USER,
	CHECKIN_USER,
	COMMENT_USER,
} UserPurposeType;

typedef enum {
  APPLY_PROGRESS_STATUS = -1, // in apply progress
  APPLY_NEEDED_STATUS = 0,    // not join
  APPLY_PASSED_STATUS = 1,    // joined
} GroupJoinApplyStatus;

// cell type
typedef enum {
	INPUT_TY,
	TXT_TY,
} CellType;

// message type
typedef enum {
	SUCCESS_TY,
  INFO_TY,
	WARNING_TY,
	ERROR_TY,
} MessageType;

// title view type
typedef enum {
  COMMUNITY_TY = 0,
  CLASS_TY,
} TitleViewType;

// image orientation type
typedef enum {
  IMG_LANDSCAPE_TY,
  IMG_PORTRAIT_TY,
  IMG_SQUARE_TY,
  IMG_ZERO_TY,
} ImageOrientationType;

#pragma mark - macro definition

#define RELEASE_OBJ(__POINTER) { [__POINTER release]; __POINTER = nil; }

#define TAB_NONE              -1

#define INVALIDE_INFO_VALUE   0

#define KEEP_OLD_POST_COUNT		50

#define CONTENT_FONT_SIZE     15.0f
#define ALL_VIEW_TAG          1
#define USER_VIEW_TAG         2
#define POST_VIEW_TAG         3
#define PROFILE_VIEW_TAG      4

// guide & news
#define SUBSCRIBED_IDX        0
#define ALL_IDX               1
#define JOINED_IDX            0
#define UNJOINED_IDX          1


// class related
#define CLASS_GP_ID           10000
#define CLASS_POST_IDX        0
#define CLASS_GROUP_IDX       1

// newsListViewController usage
#define NEWS                  0
#define GROUP                 1

// post tweet
#define CHAR_MAX_COUNT			140
#define TO_ALL_TY				1
#define DIRECT_MSG_TY			2
#define REPLY_TY				3
#define TO_GROUP				4
#define	TO_CLASS				5
#define TO_CLASS_GROUP			6
#define TO_UPLOAD_HOME			7
#define TO_UPLOAD_COMPANY		8
#define TO_COMMENT				9
#define TO_FEEDBACK				10
#define TO_USERINFO_UPDATE		11
#define TO_UPDATE_AVATAR		12
#define TO_SWITCH_CLASS			13
#define TO_RECOMMEND_GROUP		14
#define TO_UPLOAD_RECOMMEND		15
#define TO_PRAISE				16
#define TO_CHECKIN				17
#define TO_GET_PRAISE_STATUS    18
#define TO_GET_CHECKIN_STATUS   19
#define TO_RECOMMEND_COMMENT	20
#define TO_UPLOAD_MERCHANT_LOC	21
#define TO_MODIFY_ITEM			22
#define TO_CORPORATE            23
#define TO_COPY_RECOMMEND       24
#define TO_SHOW_HELP_NOTIFIER   25
#define TO_SHOW_COMPANY_GP_MSG  26  // TODO this constant should be removed after real company be added in next release
#define TO_LOCATION_ERR         27
#define TO_SHOW_INFO            28
#define TO_CHECKIN_GROUP        29

#pragma mark - local store identifier
#define SHOW_HELP_COUNT         @"showHelpCount"

// course
#define COURSE_FILES_KEY        @"files"

// url
#define SHORTURL_ENCODE_URL     @"http://tinyurl.com/api-create.php?url=%@"
#define SHORT_URL_COM           @"tinyurl.com"

#define LOHAS_IMG               @"LOHAS_IMG"

#define APPLE_SCHEME            @"applewebdata"
#define WEBVIEW_IMG_URL         @"//image"
#define HTTP_PRIFIX             @"http"
#define HTTPS_PRIFIX            @"https"
#define TEL_PRIFIX              @"tel"

// image
#define PNG_POSTFIX             @"png"
#define JPG_POSTFIX             @"jpg"
#define GIF_POSTFIX             @"gif"

// all city
#define ALL_CITY				@"*"

// location timer interval
#define LOC_INTERVAL                60 * 15

// new count refreshment timeer interval
#define NEW_COUNT_REFRESH_INTERVAL  60 * 15

// edit post view
#define TEXT_PORTRAIT_WITHTO_HEIGHT		120.0f
#define TEXT_PORTRAIT_WITHOUTTO_HEIGHT	140.0f
#define TEXT_LANDSCAPE_WITHTO_HEIGHT	55.0f
#define TEXT_LANDSCAPE_WITHOUTTO_HEIGHT	65.0f
#define VIEW_LANDSCAPE_WIDTH			470.0f
#define VIEW_PORTRAIT_WIDTH				320.0f
#define CHAR_COUNT_LANDSCAPE_WITHTO_Y	10.0f

// photo cell
#define DEL_BTN_TAG(index)				(index + 1) * 10 + 1
#define UNDO_BTN_TAG(index)				(index + 1) * 10 + 2
#define ROW_INDEX_DEL_BTN(tagValue)		(tagValue - 1)/10 - 1
#define ROW_INDEX_UNDO_BTN(tagValue)	(tagValue - 2)/10 - 1

// table footer view
#define FOOTER_PORTRAIT_WIDTH			320.0f
#define FOOTER_LANDSCAPE_WIDTH			480.0f

// network
#define NET_RESP_OK						200

// login/signup related
#define LOGIN_SIGNUP_OK					200
#define USER_BEEN_TAKEN					501
#define EMAIL_BEEN_TAKEN				500
#define USER_VERIFY_OK					0
#define USER_VERIFY_FAILED				1
#define USER_VERIFY_TIMEOUT				2

#define	KEYBOARD_ANIMATION_DURATION		0.3f
#define MINIMUM_SCROLL_FRACTION			0.2f
#define MAXIMUM_SCROLL_FRACTION			0.9f
#define PORTRAIT_KEYBOARD_HEIGHT		216.0f
#define LANDSCAPE_KEYBOARD_HEIGHT		162.0f

// table refreshment
#define HEADER_TRIGGER_OFFSET			65.0f
#define FOOTER_TRIGGER_OFFSET_IPHONE	330.0f
#define FOOTER_TRIGGER_OFFSET_IPAD		854.0f
#define FOOTER_TRIGGER_OFFSET_MAX		330.0f
#define FOOTER_TRIGGER_OFFSET_MIN		240.0f

// load content type
#define USER_VERIFY				0
#define LOAD_NEW_POST			1
#define LOAD_OLD_POST			2  
#define SEND_POST				3
#define LOAD_CLASS_GROUPS		4
#define LOAD_CLASSES			5
#define LOAD_TRACE_POST			6
#define JOIN_GORUP			    7
#define LOAD_COMMENT			8
#define FETCH_USERINFO			9
#define UPDATE_USERINFO			10
#define UPDATE_AVATAR			11
#define GET_HOST				12

// language type
#define EN_TY					0
#define ZH_HANS_TY				1

// draft post
#define NEW_POST_ID				-1

// photo type
enum {
  AUTHOR_PHOTO_TY = 0,
  POST_IMAGE_TY,
  POST_LIST_IMAGE_TY,
  RECOMMEND_PHOTO_TY,
  ACTIVITY_PHOTO_TY,
  COOP_PHOTO_TY,
  COURSE_PHOTO_TY,
};
/*
#define AUTHOR_PHOTO_TY			0
#define POST_IMAGE_TY			1
#define RECOMMEND_PHOTO_TY		2
#define ACTIVITY_PHOTO_TY		3
#define COOP_PHOTO_TY           4
#define COURSE_PHOTO_TY 5
 */

// photo size
#define LOADING_IMG_WIDTH       36//320
#define LOADING_IMG_HEIGHT      36//170
#define PHOTO_LONG_LEN_IPHONE   180//280
#define PHOTO_SHORT_LEN_IPHONE	135//210
#define	PHOTO_LONG_LEN_1G3G     600	
#define PHOTO_SHORT_LEN_1G3G    450
#define	PHOTO_LONG_LEN_3GS      640	
#define PHOTO_SHORT_LEN_3GS     480
#define	PHOTO_LONG_LEN_4G       680	
#define PHOTO_SHORT_LEN_4G      510

#define FRONT_PHOTO_LONG_LEN    640.0f
#define FRONT_PHOTO_SHORT_LEN   480.0f

#define AVATAR_WIDTH_IPHONE     200
#define AVATAR_HEIGHT_IPHONE    200

// trace type
#define NONE_LOC                0
#define TRACE_LOC               1
#define HAPPY_LOC               2

// color
#define COLOR(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define BACKGROUND_COLOR                COLOR(240,248,255)

#define RED_BTN_BORDER_COLOR            COLOR(205,50,6)
#define RED_BTN_TITLE_COLOR             COLOR(238,92,66)
#define RED_BTN_TITLE_SHADOW_COLOR      [UIColor whiteColor]
#define RED_BTN_TOP_COLOR               COLOR(255,250,205)
#define RED_BTN_BOTTOM_COLOR            COLOR(255,193,37)

#define BLUE_BTN_BORDER_COLOR           COLOR(16,78,139)
#define BLUE_BTN_TITLE_COLOR            [UIColor whiteColor] 
#define BLUE_BTN_TITLE_SHADOW_COLOR     [UIColor blackColor]
#define BLUE_BTN_TOP_COLOR              COLOR(209,238,238)
#define BLUE_BTN_BOTTOM_COLOR           COLOR(79,148,205)

#define GRAY_BTN_BORDER_COLOR           [UIColor darkGrayColor]
#define GRAY_BTN_TITLE_COLOR            [UIColor darkGrayColor] 
#define GRAY_BTN_TITLE_SHADOW_COLOR     [UIColor whiteColor] 
#define GRAY_BTN_TOP_COLOR              [UIColor whiteColor]
#define GRAY_BTN_BOTTOM_COLOR           [UIColor lightGrayColor]

#define GRAY_HEADERVIEW_TOP_COLOR       COLOR(234,234,234)
#define GRAY_HEADERVIEW_BOTTOM_COLOR    COLOR(186,186,186)
#define GRAY_HEADERVIEW_BORDER_COLOR    COLOR(89,89,89)

#define BLUE_CELL_BORDER_COLOR          COLOR(0,0,238)
#define BLUE_CELL_DARK1_COLOR           COLOR(24,116,205)
#define BLUE_CELL_DARK2_COLOR           COLOR(0,0,255)
#define BLUE_CELL_LIGHT_COLOR           COLOR(72,118,255)

// UI elements size
#define CELL_CONTENT_MARGIN         5.0f
#define STANDARD_CELL_HEIGHT        44.0f
#define HEADER_HEIGHT               55.0f
#define PHOTO_IMAGE_SMALL_LEN       40.0f
#define TOOL_MENU_HEIGHT            40.0f

// font
#define BOLD_FONT(aSize)            [UIFont fontWithName:kBold size:aSize]
#define FONT(aSize)                 [UIFont fontWithName:kFontHelveticaNeue size:aSize]

// notification name
#define SET_PICKER_NIL_NOTIFICATION       @"SET_PICKER_NIL_NOTIFICATION"
#define CLEAR_HANDY_IMAGE_BROWSER_NOTIF   @"CLEAR_HANDY_IMAGE_BROWSER_NOTIF"
#define CELL_LONG_PRESS_NOTIF             @"CELL_LONG_PRESS_NOTIF"
#define CELL_LONG_PRESS_IDX_KEY           @"LongPressedCell"
#define EDIT_POST_NOTIF                   @"EDIT_POST_NOTIF"
#define DELETE_POST_NOTIF                 @"DELETE_POST_NOTIF"
#define COMMENT_POST_NOTIF                @"COMMENT_POST_NOTIF"
#define LIKE_POST_NOTIF                   @"LIKE_POST_NOTIF"
#define UPDATE_LIKE_IMAGE_NOTIF           @"UPDATE_LIKE_IMAGE_NOTIF"
#define POST_ACTOIN_KEY                   @"PostActionKey"

static NSString *const IFACECHINA_FORM_BOUNDARY = @"IFaceChinaiPhone072829";

@interface GlobalConstants : NSObject {
	
}

#pragma mark -
#pragma mark home page
extern NSString *const kNewStatusTitle; 	
extern NSString *const kActivityTitle; 
extern NSString *const kRecommendAndActvityTitle;
extern NSString *const kLocationTitle; 
extern NSString *const kNotificationTitle;
extern NSString *const kHomePageTitle;
extern NSString *const kNoActivityGroupTitle;
extern NSString *const kNoRecommendGroupTitle;
extern NSString *const kCurrentClassTitle;
extern NSString *const kCurrentCommunityTitle;
extern NSString *const kQATitle;
extern NSString *const kGetQAGroupFailedMsg;
extern NSString *const kAlumniHappyTitle;
extern NSString *const kAlumniCoopTitle;
extern NSString *const kProfAssocTitle;
extern NSString *const kLogoTitle;
extern NSString *const kLogoutNotifyMsg;
extern NSString *const kContactUsTitle;
extern NSString *const kHelpTitle;
extern NSString *const kSurveyTitle;
extern NSString *const kClassManagementTitle;
extern NSString *const kTeamCoopTitle;
extern NSString *const kDiscussGroupTitle;
extern NSString *const kEnterpriseCollegeTitle;
extern NSString *const kSalesManagementTitle;
extern NSString *const kChannelManagementTitle;
extern NSString *const kPublicOpinionMonitorTitle;
extern NSString *const kWisDomJackTitle;
extern NSString *const kWisDomMatsTitle;

#pragma mark -
#pragma mark title 
extern NSString *const kIFaceChina;
extern NSString *const kSubChannelTitle;
extern NSString *const kNewsChannelTitle;
extern NSString *const kGroupTitle;
extern NSString *const kCompanyGroupTitle;
extern NSString *const kFollowGroupTitle;
extern NSString *const kMyMsgTitle;
extern NSString *const kTweetsTitle;
extern NSString *const kFavoriteTitle;
extern NSString *const kMoreTitle;
extern NSString *const kUsername;
extern NSString *const kPassword;
extern NSString *const kAccountHeader;
extern NSString *const kUsernamePlaceholder;
extern NSString *const kRegUsernamePlaceholder;
extern NSString *const kPasswordPlaceholder;
extern NSString *const kEmailPlaceholder;
extern NSString *const kConfirmPasswordPlaceholder;
extern NSString *const kRegisterHeader;
extern NSString *const kForgetPasswordTitle;
extern NSString *const kFindPasswordTitle;
extern NSString *const kConfrimPassword;
extern NSString *const kEmail;
extern NSString *const kRegisterBtnTitle;
extern NSString *const kBackBtnTitle;
extern NSString *const kReferrerTitle;
extern NSString *const kReferrerPlaceholder;
extern NSString *const kUserInfoIsNil;
extern NSString *const kUserInfoNeeded;
extern NSString *const kEmailInvalid;
extern NSString *const kEmailFormstSpecify;
extern NSString *const kGuideTitle;
extern NSString *const kClassTitle;
extern NSString *const kYesTitle;
extern NSString *const kNoTitle;

#pragma mark -
#pragma mark class related
extern NSString *const kClassSpeakTitle;
extern NSString *const kClassGroupsTitle;
extern NSString *const kMyClass;
extern NSString *const kLoadClassFailed;
extern NSString *const kInvalideUrlParam;
extern NSString *const kNoAuthorForQueryGroupInClass;
extern NSString *const kQueryGroupInClassFailed;
extern NSString *const kQueryClassesFailed;
extern NSString *const kNoAuthorForQueryClasses;
extern NSString *const kLoadRecommendGpFailedMsg;
extern NSString *const kCompanyGroupMsg;
extern NSString *const kLoadCheckAndLohasGroupsFailedMsg;
extern NSString *const kLoadEnterpriseGroupsFailedMsg;

#pragma mark -
#pragma mark signup related
extern NSString *const kUsernameEmpty;
extern NSString *const kUsernameEmptyInstruction;
extern NSString *const kEmailEmpty;
extern NSString *const kEmailEmptyInstruction;
extern NSString *const kPasswordEmpty;
extern NSString *const kPasswordEmptyInstruction;
extern NSString *const kPasswordMismatch;
extern NSString *const kPasswordMismatchInstruction;
extern NSString *const kUsernameWrongFormat;
extern NSString *const kUsernameWrongFormatInstruction;
extern NSString *const kRegisterSuccess;
extern NSString *const kRegisterStatus;
extern NSString *const kLoginFailed;
extern NSString *const kTryAgain;
extern NSString *const kUserBeenTaken;
extern NSString *const kEmailBeenTaken;
extern NSString *const kRegisterFailed;
extern NSString *const kUserLoginTitle;

#pragma mark -
#pragma mark device related
extern NSString *const kVersion;

#pragma mark -
#pragma mark login related
extern NSString *const kLoginStatus;
extern NSString *const kLoginSuccess;
extern NSString *const kAuthFailed;
extern NSString *const kWrongLoginInfo;
extern NSString *const kLoginPageMsgTitle;
extern NSString *const kYouCanDoTitle;
extern NSString *const kLoginPageMsgShareTitle;
extern NSString *const kLoginPageMsgMapTitle;
extern NSString *const kLoginPageMsgCoopTitle;
extern NSString *const kLoginPageRecommendTitle;
extern NSString *const kLoginPageMsgContactTitle;
extern NSString *const kAlumniApplyTitle;
extern NSString *const kApplyJoinTitle;
extern NSString *const kApplyJoinWapTitle;
extern NSString *const kHotlineTitle;
extern NSString *const kHelpNotifiyInfo;
extern NSString *const kUserInactiveInfo;

#pragma mark -
#pragma mark font
extern NSString *const kFontHelveticaNeue;
extern NSString *const kUserRegisterTitle;
extern NSString *const kLoginTitle;
extern NSString *const kBold;

#pragma mark -
#pragma mark icon
extern NSString *const kLogoIcon;

#pragma mark -
#pragma mark UI element related
extern NSString *const kCloseTitle;
extern NSString *const kSendTitle;
extern NSString *const kImageAttached;
extern NSString *const kCommentAttached;
extern NSString *const kLoadingStatusTitle;
extern NSString *const kSwitchingTitle;
extern NSString *const kPullDownToRefresh;
extern NSString *const kReleaseToRefresh;
extern NSString *const kLastUpdate;
extern NSString *const kLoadMore;
extern NSString *const kEditBtnTitle;
extern NSString *const kDoneBtnTitle;
extern NSString *const kPrePageTitle;
extern NSString *const kNextPageTitle;
extern NSString *const kCopyBtnTitle;
extern NSString *const kProcessingTitle;
extern NSString *const kLoginingTitle;
extern NSString *const kCreatingTitle;
extern NSString *const kCopyingTitle;
extern NSString *const kModifyingTitle;
extern NSString *const kBackToHomePageTitle;
extern NSString *const kBackToClassGroupTitle;
extern NSString *const kBackToLohasTitle;
extern NSString *const kBackToLohasContentTitle;
extern NSString *const kBackToLoginTitle;
extern NSString *const kBackToProAssociationTitle;

#pragma mark -
#pragma mark network
extern NSString *const kPost;
extern NSString *const kGet;
extern NSString *const kFormAuthValue;
extern NSString *const kHttpHeaderFieldType;
extern NSString *const kHttpHeaderFieldLength;
extern NSString *const kNetErrTryAgain;
extern NSString *const kConnFailed;
extern NSString *const kResponseOKCode;
extern NSString *const kConnUnavailable;
extern NSString *const kOnlyReadCachedData;
extern NSString *const kEnsureConnIsOK;
extern NSString *const kShortUrlImg;
extern NSString *const kShortUrlStatusMsg;
extern NSString *const kNoLongUrlFound;
extern NSString *const kHttpHeaderTitle;
extern NSString *const kPhoneControllerTitle;
extern NSString *const kCEIBS;
extern NSString *const kNoResponseMsg;
extern NSString *const kParserXmlErrMsg;

#pragma mark -
#pragma mark database
extern NSString *const kDBName;
extern NSString *const kVersionOneDBName;
extern NSString *const kUserInfoDBName;
extern NSString *const kCoreDataCacheDBName;

#pragma mark -
#pragma mark guide & news
extern NSString *const kMyNewsTitle;
extern NSString *const kAllNewsTitle;
extern NSString *const kUnfollowingStatus;
extern NSString *const kFollowingStatus;
extern NSString *const kUnsubscribingStatus;
extern NSString *const kSubscribingStatus;
extern NSString *const kSubscribedInfoTitle;
extern NSString *const kAllInfoTitle;
extern NSString *const kNewsTitle;

#pragma mark -
#pragma mark groups related
extern NSString *const kJoinedStatus; 
extern NSString *const kUnjoinedStatus;
extern NSString *const kJoinAction;
extern NSString *const kLeaveAction;
extern NSString *const kUpdatesTitle;
extern NSString *const kMembersTitle;
extern NSString *const kAdminsTitle;
extern NSString *const kPrivateGroupTitle;
extern NSString *const kPublicGroupTitle;
extern NSString *const kMembers;
extern NSString *const kPosts;
extern NSString *const kGroupProfile;
extern NSString *const kJoinedGroups;
extern NSString *const kJoinedGroupsTitle;
extern NSString *const kAllGroupsTitle;
extern NSString *const kToGroup;
extern NSString *const kSpeak;
extern NSString *const kActionFailedTitle;
extern NSString *const kJoinedCountTitle;
extern NSString *const kApplyProgressTitle;

#pragma mark -
#pragma mark tweet related
extern NSString *const kTweetContent;
extern NSString *const kUndo;
extern NSString *const kDirectMsgTitle;
extern NSString *const kNewTweetTitle;
extern NSString *const kTweetCannotSent;
extern NSString *const kReceiverNameIncorrect;
extern NSString *const kTakeMAXCountPhotoTitle;
extern NSString *const kClearCurrentSelection;
extern NSString *const kHandlePhotoTitle;
extern NSString *const kTakePhoto;
extern NSString *const kChooseExistingPhoto;
extern NSString *const kCancel;
extern NSString *const kErrorShortenURL;
extern NSString *const kAllRecipient;
extern NSString *const kSendFailed;
extern NSString *const kDuplicatePost;
extern NSString *const kSendFailedDueToSomeCause;
extern NSString *const kPostSentSuccessfulTitle;
extern NSString *const kHomeLocateSuccessfulTitle;
extern NSString *const kCompanyLocationOKTitle;
extern NSString *const kCreateCommentTitle;
extern NSString *const kCommentSuccessfulTitle;
extern NSString *const kCommentSendFailedTitle;
extern NSString *const kCommentEmptyTitle;
extern NSString *const kCommentCreatedFailed;
extern NSString *const kCreatedAtTitle;
extern NSString *const kOpenCommentTitle;
extern NSString *const kCommentTitle;
extern NSString *const kSelectRecipientTitle;
extern NSString *const kMyClassTitle;
extern NSString *const kWithSMSTitle;
extern NSString *const kPostWithSMSTitle;
extern NSString *const kPostWithSMSDetailTitle;
extern NSString *const kRecipientSelectionTitle;
extern NSString *const kAddCommentTitle;
extern NSString *const kBigPicTitle;
extern NSString *const kClickImageForBigTitle;
extern NSString *const kSumCommentTitle;
extern NSString *const kCommentEntryTitle;
extern NSString *const kCloseNotificationTitle;
extern NSString *const kCloseFeedbackTitle;
extern NSString *const kCorporateTitle;
extern NSString *const kPhotoEffectHandleTitle;
extern NSString *const kOriginalImageTitle;
extern NSString *const kBWImageTitle;
extern NSString *const kSaveImageSuccessMsg;
extern NSString *const kDeletePostWarningMsg;
extern NSString *const kDeleteTitle;
extern NSString *const kDeletePostFailedMsg;
extern NSString *const kUpdatePostFailedMsg;
extern NSString *const kSortByNewCommentTimeTitle;
extern NSString *const kSortByCommentCountTitle;
extern NSString *const kSortByHotTitle;

#pragma mark - coop related
extern NSString *const kAlumniCoopCategoryTitle;

#pragma mark -
#pragma mark recommend related
extern NSString *const kNameTitle;
extern NSString *const kCityLocationTitle;
extern NSString *const kAddressTitle;
extern NSString *const kPhoneNumberTitle;
extern NSString *const kIntroTitle;
extern NSString *const kDetailInfoTitle;
extern NSString *const kDetailLinkTitle;
extern NSString *const kUploadPhotoTitle;
extern NSString *const kSelectTitle;
extern NSString *const kDeleteOrChangePhotoTitle;
extern NSString *const kAddNewRecommendItemTitle;
extern NSString *const kAddNewActivityItemTitle;
extern NSString *const kCreateNewItemTitle;
extern NSString *const kNameHolderTitle;
extern NSString *const kAddressHolderTitle;
extern NSString *const kPhoneNumberHolderTitle;
extern NSString *const kIntroHolderTitle;
extern NSString *const kDetailInfoHolderTitle;
extern NSString *const kFailedToFetchCityFromWeb;
extern NSString *const kShanghaiTitle;
extern NSString *const kBeijingTitle;
extern NSString *const kHangzhouTitle;
extern NSString *const kNanjingTitle;
extern NSString *const kGuangzhouTitle;
extern NSString *const kTianjinTitle;
extern NSString *const kChengduTitle;
extern NSString *const kChongqingTitle;
extern NSString *const kWuhanTitle;
extern NSString *const kXianTitle;
extern NSString *const kJinnanTitle;
extern NSString *const kQingdaoTitle;
extern NSString *const kShenzhenTitle;
extern NSString *const kHongkongTitle;
extern NSString *const kDalianTitle;
extern NSString *const kHaerbinTitle;
extern NSString *const kKunmingTitle;
extern NSString *const kSimpleIntroTitle;
extern NSString *const kSortByPraiseTitle;
extern NSString *const kSortByCheckTitle;
extern NSString *const kSortByCommentTitle;
extern NSString *const kSortByCreateTimeTitle;
extern NSString *const kSortByHoldDateTitle;
extern NSString *const kSortTitle;
extern NSString *const kPraiseTitle;
extern NSString *const kCheckinTitle;
extern NSString *const kRecommendFailedTitle;
extern NSString *const kRecommendSuccessTitle;
extern NSString *const kUploadPhotoSuccessTitle;
extern NSString *const kUploadItemSuccessTitle;
extern NSString *const kCopyItemSuccessTitle;
extern NSString *const kPraiseCountTitle;
extern NSString *const kCheckinCountTitle;
extern NSString *const kLearnedCountTitle;
extern NSString *const kCommentCountTitle;
extern NSString *const kPraiseFailedParaErrMsg;
extern NSString *const kPraiseFailedParaIncomMsg;
extern NSString *const kCheckinFailedParaErrMsg;
extern NSString *const kCheckinFailedParaIncomMsg;
extern NSString *const kGetPraiseCountFailedTitle;
extern NSString *const kUnpraiseTitle;
extern NSString *const kGetCheckinCountFailedTitle;
extern NSString *const kMerchantInfoTitle;
extern NSString *const kActivityInfoTitle;
extern NSString *const kEntryTitle;
extern NSString *const kRecommendItemInfoTitle;
extern NSString *const kSeorangeTitle;
extern NSString *const kBrowseMapTitle;
extern NSString *const kMapTitle;
extern NSString *const kMerchantNoMapInfoTitle;
extern NSString *const kUpdateLocTitle;
extern NSString *const kUploadLocTitle;
extern NSString *const kActivityCategoryTitle;
extern NSString *const kHappyCategoryTitle;
extern NSString *const kPraisedUserListTitle;
extern NSString *const kCheckinUserListTitle;
extern NSString *const kLearnedUserListTitle;
extern NSString *const kRecommendItemCommentTitle;
extern NSString *const kCommentDetailTitle;
extern NSString *const kOpenImgTitle;
extern NSString *const kCheckedinMsg;
extern NSString *const kUpdateLocationFailedTitle;
extern NSString *const kRemarkTitle;
extern NSString *const kRemarkAndPhotoTitle;
extern NSString *const kInputCityTitle;
extern NSString *const kEditTitle;
extern NSString *const kEditItemTitle;
extern NSString *const kEditRecommendItemTitle;
extern NSString *const kEditActivityItemTitle;
extern NSString *const kAllTitle;
extern NSString *const kCitySelectScopeTitle;
extern NSString *const kModifySucessTitle;
extern NSString *const kSyncToSinaTitle;
extern NSString *const kContactTitle;
extern NSString *const kContactPlaceHolder;
extern NSString *const kEditNotificationTitle;
extern NSString *const kCancelItemCreationNotifyTitle;
extern NSString *const kBlankItemNotifyTitle;
extern NSString *const kCancelItemUpdateNotifyTitle;
extern NSString *const kBrowseTitle;
extern NSString *const kBrowseCheckinTitle;
extern NSString *const kBrowseRemarkTitle;
extern NSString *const kBrowsePraiseTitle;
extern NSString *const kSendSuccessTitle;
extern NSString *const kRemarkListTitle;
extern NSString *const kCopyRecommendItemTitle;
extern NSString *const kCopyActivityItemTitle;
extern NSString *const kAlumniContentTitle;
extern NSString *const kCheckinFailedNoLocMsg;
extern NSString *const kCheckinFailedNotStartMsg;
extern NSString *const kCheckinFailedExpiredMsg;
extern NSString *const kCheckinFailedOutScopeMsg;
extern NSString *const kIamHereSendTitle;
extern NSString *const kDistanceTitle;
extern NSString *const kMeterTitle;
extern NSString *const kCheckinPlaceHolderTitle;
extern NSString *const kItemDateTitle;
extern NSString *const kCourseCategoryTitle;
extern NSString *const kCourseLearnedPeopleCountTile;
extern NSString *const kLearnTitle;
extern NSString *const kTestTitle;
extern NSString *const kDocTitle;
extern NSString *const kDownloadTitle;
extern NSString *const kDiscussCategoryTitel;

#pragma mark -
#pragma mark member related
extern NSString *const kFollowActionTitle;
extern NSString *const kUnfollowActionTitle;
extern NSString *const kSubscribeTitle;
extern NSString *const kUnsubscribeTitle;
extern NSString *const kUserProfileTitle;
extern NSString *const kFollowingTitle;
extern NSString *const kFollowersTitle;
extern NSString *const kGroupsTitle;
extern NSString *const kProfileTweetTitle;
extern NSString *const kSaveActionSheetTitle;
extern NSString *const kUnsaveActionSheetTitle;
extern NSString *const kCallActionSheetTitle;
extern NSString *const kCallTitle;
extern NSString *const kIndustryTitle;
extern NSString *const kSinaWeiboTitle;

#pragma mark -
#pragma mark network related
extern NSString *const kTimeout;

#pragma mark -
#pragma mark location related
extern NSString *const kLocationSevErr;
extern NSString *const kLocationTimeOut;
extern NSString *const kLocationImg;
extern NSString *const kSMSAttachedImg;

#pragma mark -
#pragma mark file related
extern NSString *const kZipFileName;

#pragma mark -
#pragma mark more setting
extern NSString *const kDraftBoxTitle;
extern NSString *const kSendToTitleForDraft;
extern NSString *const kSavedToDraftTitle;
extern NSString *const kSendFailedTitle;
extern NSString *const kEditFailedTitle;
extern NSString *const kProfileSettingTitle;
extern NSString *const kProfilePhotoTitle;
extern NSString *const kNameSettingTitle;
extern NSString *const kEmailSettingTitle;
extern NSString *const kPhoneSettingTitle;
extern NSString *const kCompanySettingTitle;
extern NSString *const kAddMyHomeLocationTitle;
extern NSString *const kAddMyCompanyLocationTitle;
extern NSString *const kMyHomeTitle;
extern NSString *const kMyCompanyTitle;
extern NSString *const kMyHomeIsHereTitle;
extern NSString *const kMyCompanyIsHereTitle;
extern NSString *const kFeedbackTitle;
extern NSString *const kFeedbackSuccessfulTitle;
extern NSString *const kBioTitle;
extern NSString *const kChangePasswdTitle;
extern NSString *const kChangePhoneTitle;
extern NSString *const kChangeEmailTitle;
extern NSString *const kChangeCompanyTitle;
extern NSString *const kChangeBioTitle;
extern NSString *const kInfoUpdateFailedTitle;
extern NSString *const kInfoUpdateSuccessTitle;
extern NSString *const kUploadAvatarFailedTitle;
extern NSString *const kUploadAvatarOKTitle;
extern NSString *const kSwitchClassTitle;
extern NSString *const kClassListTitle;
extern NSString *const kSwitchClassFailedTitle;
extern NSString *const kSwitchClassSuccessTitle;
extern NSString *const kLogoutTitle;
extern NSString *const kChangeIndustryTitle;
extern NSString *const kChangeSinaWeiboTitle;
extern NSString *const kFeedbackInstrTitle;
extern NSString *const kFeedbackPlaceHolderTitle;
extern NSString *const kSwitchCommunityFailedMsg;
extern NSString *const kSwitchCommunitySuccessTitle;
extern NSString *const kJobtitle;
extern NSString *const kDepartmentTitle;
extern NSString *const kChangeJobTitle;
extern NSString *const kChangeDepartmentTitle;
extern NSString *const kChagneCityLocationTitle;


#pragma mark - enterprise management
extern NSString *const kTaskTitle;
extern NSString *const kSubTaskTitle;
extern NSString *const kTermManagementTitle;
extern NSString *const kSubTermManagementTitle;
extern NSString *const kProductInfoTitle;
extern NSString *const kSubProductInfoTitle;
extern NSString *const kKpiReportTitle;
extern NSString *const kSubKpiReportTitle;
extern NSString *const kBackToSalesTitle;

#pragma mark -
#pragma mark map related
extern NSString *const kNearbyClassmateTitle;
extern NSString *const kUserLocationTitle;
extern NSString *const kNoNearbyPeopleTitle;
extern NSString *const kNearbyHappyTitle;
extern NSString *const kAluminCheckinTitle;
extern NSString *const kNearbyHappyCheckinTitle;
extern NSString *const kNearbyHappyItemTitle;
extern NSString *const kNoNearbyPeopleDetailTitle;
extern NSString *const kHappyTitle;
extern NSString *const kMapModelTitle;

@end
