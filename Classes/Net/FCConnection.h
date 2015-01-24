//
//  FCConnection.h
//  iFaceChina
//
//  Created by MobGuang on 10-8-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


@interface FCConnection : NSObject {
	id delegate;
	NSString *requestUrl;
	NSURLConnection *connection;
	NSMutableData *buf;
	int statusCode;
	BOOL needAuth;
}

@property (nonatomic, readonly) NSMutableData* buf;
@property (nonatomic, assign) int statusCode;
@property (nonatomic, copy) NSString *requestUrl;

- (id)initWithDelegate:(id)delegate;
- (void)get:(NSString *)aUrl;
- (void)post:(NSString *)aUrl body:(NSString *)body;
- (void)post:(NSString *)aUrl data:(NSData *)data;
- (void)cancel;

- (BOOL)checkResponse:(NSHTTPURLResponse *)resp;
- (void)FCConnectionDidFailWithError:(NSError *)error;
- (void)FCConnectionDidFinishLoading:(NSString *)content;

@end
