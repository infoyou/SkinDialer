//
//  SqliteUtil.m
//  SkinDialer
//
//  Created by Adam on 11-6-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SqliteUtil.h"

@implementation SqliteUtil
static sqlite3 *database = nil;

+ (NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database"];
//	NSLog(@"documentsDirectory is %@",path);
	return path;
}

+ (void)openDB
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Failed to open database");
    }else{
		NSLog(@"Open database success");
	}
}

+ (void)createTable
{
	[self openDB];
    char *errorMsg;
	
	NSString *createSQL = @"CREATE TABLE IF NOT EXISTS RecentCall (ROW integer PRIMARY KEY, CallMsg text, CallDate double, CallFlag text, CallDuration text);";
	
    if (sqlite3_exec (database, [createSQL  UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Error creating table: %s", errorMsg);
    }else {
		NSLog(@"creating table success");
	}
}

+ (int)selectTable
{
	[self openDB];
	
	int count;
	
    NSString *query = @"SELECT * FROM RecentCall ORDER BY ROW";
    sqlite3_stmt *statement;
	
	if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
		
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int row = sqlite3_column_int(statement, 0);
			//			NSLog(@"row = %d", row );
			count = row;
		}
        sqlite3_finalize(statement);
    } 	
	
	return count;	
}

+ (NSMutableArray *)selMissCallBySqlite
{
    [self openDB];
    
	NSLog(@"selRecentCallBySqlite selectDB method");
	NSMutableArray *recentCalls = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT ROW, CallMsg, CallDate, CallFlag, CallDuration FROM RecentCall WHERE CallFlag = '0' ORDER BY ROW desc";
    sqlite3_stmt *statement;
	
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
		
        while (sqlite3_step(statement) == SQLITE_ROW) {			
            char *callMsgRowData = (char *)sqlite3_column_text(statement, 1);
            NSString *callMsg = [[NSString alloc] initWithUTF8String:callMsgRowData];
			
			char *callFlagRowData = (char *)sqlite3_column_text(statement, 3);
            NSString *callFlag = [[NSString alloc] initWithUTF8String:callFlagRowData];
			
			char *callDurationRowData = (char *)sqlite3_column_text(statement, 4);
            NSString *callDuration = [[NSString alloc] initWithUTF8String:callDurationRowData];
			NSLog(@"callDuration is %@",callDuration);
			
			RecentCallBean *recentCall = [[RecentCallBean alloc] init];
			
			recentCall.T_ID = [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 0)];
			recentCall.T_PhoneNumber = callMsg;
			recentCall.T_CallDate = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_double(statement, 2)];
			recentCall.T_CallFlag = callFlag;
			recentCall.T_CallDuration = callDuration;
			
			[recentCalls addObject:recentCall];
            [callMsg release];
			[callFlag release];
			[callDuration release];
        }
        sqlite3_finalize(statement);
    } 	
	return recentCalls;
}


+ (NSMutableArray *)selRecentCallBySqlite
{
    [self openDB];
    
	NSLog(@"selRecentCallBySqlite selectDB method");
	NSMutableArray *recentCalls = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT ROW, CallMsg, CallDate, CallFlag, CallDuration FROM RecentCall ORDER BY ROW desc";
    sqlite3_stmt *statement;
	
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
		
        while (sqlite3_step(statement) == SQLITE_ROW) {			
            char *callMsgRowData = (char *)sqlite3_column_text(statement, 1);
            NSString *callMsg = [[NSString alloc] initWithUTF8String:callMsgRowData];
			
			char *callFlagRowData = (char *)sqlite3_column_text(statement, 3);
            NSString *callFlag = [[NSString alloc] initWithUTF8String:callFlagRowData];
			
			char *callDurationRowData = (char *)sqlite3_column_text(statement, 4);
            NSString *callDuration = [[NSString alloc] initWithUTF8String:callDurationRowData];
			NSLog(@"callDuration is %@",callDuration);
			
			RecentCallBean *recentCall = [[RecentCallBean alloc] init];
			
			recentCall.T_ID = [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 0)];
			recentCall.T_PhoneNumber = callMsg;
			recentCall.T_CallDate = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_double(statement, 2)];
			recentCall.T_CallFlag = callFlag;
			recentCall.T_CallDuration = callDuration;
			
			[recentCalls addObject:recentCall];
            [callMsg release];
			[callFlag release];
			[callDuration release];
        }
        sqlite3_finalize(statement);
    } 	
	return recentCalls;
}

+ (void)insertDB:(RecentCallBean*)recentCall
{
	NSLog(@"insertDB Method");
	
	char *errorMsg;
	char *update = "INSERT OR REPLACE INTO RecentCall (ROW, CallMsg, CallDate, CallFlag, CallDuration) VALUES (?,?,?,?,?);";
	sqlite3_stmt *stmt;
	if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
		sqlite3_bind_int(stmt, 1, [self selectTable] + 1);
		sqlite3_bind_text(stmt, 2, [[recentCall T_PhoneNumber] UTF8String], -1, NULL);
		sqlite3_bind_double(stmt, 3, [[recentCall T_CallDate] timeIntervalSince1970]);
		sqlite3_bind_text(stmt, 4, [[recentCall T_CallFlag] UTF8String], -1, NULL);
		sqlite3_bind_text(stmt, 5, [[recentCall T_CallDuration] UTF8String], -1, NULL);
	}
	
	if (sqlite3_step(stmt) != SQLITE_DONE){
		NSLog(@"Error updating table: %s", errorMsg);
	}else {
		NSLog(@"Insert Success");
	}
	
	sqlite3_finalize(stmt);
	
    sqlite3_close(database);
}

+ (void) deleteTableByID:(int) aCallId
{
	NSLog(@"deleteTableByID Method id is %d", aCallId);
	
	char *errorMsg;
	char *deleteStat = "Delete from RecentCall where ROW = ?";
	sqlite3_stmt *stmt;
	if (sqlite3_prepare_v2(database, deleteStat, -1, &stmt, nil) == SQLITE_OK) {
		sqlite3_bind_int(stmt, 1, aCallId);
	}
	if (sqlite3_step(stmt) != SQLITE_DONE){
		NSLog(@"Error updating table: %s", errorMsg);
	}else {
		NSLog(@"delete Success");
	}
	
	sqlite3_finalize(stmt);
	
    sqlite3_close(database);    
}

+ (void) deleteTable
{
	NSLog(@"deleteTable Method");
	
	char *errorMsg;
	char *deleteStat = "Delete from RecentCall";
	sqlite3_stmt *stmt;
	if (sqlite3_prepare_v2(database, deleteStat, -1, &stmt, nil) == SQLITE_OK) {
		//sqlite3_bind_int(stmt, 1, aCallId);
	}
	if (sqlite3_step(stmt) != SQLITE_DONE){
		NSLog(@"Error updating table: %s", errorMsg);
	}else {
		NSLog(@"delete Success");
	}
	
	sqlite3_finalize(stmt);
	
    sqlite3_close(database);    
}


@end
