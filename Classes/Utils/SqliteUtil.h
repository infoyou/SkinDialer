//
//  SqliteUtil.h
//  SkinDialer
//
//  Created by Adam on 11-6-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecentCallBean.h"
#import "sqlite3.h"

@interface SqliteUtil : NSObject {
}

+ (void)insertDB:(RecentCallBean*)recentCall;
+ (NSMutableArray *)selMissCallBySqlite;
+ (NSMutableArray *)selRecentCallBySqlite;
+ (void) deleteTableByID:(int) aCallId;
+ (void) deleteTable;
+ (void)openDB;
+ (void)createTable;

@end
