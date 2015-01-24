//
//  FCClient.m
//  iFaceChina
//
//  Created by MobGuang on 10-8-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FCClient.h"

#import "GlobalConstants.h"


@interface FCClient(private)
- (NSData *)assembleContentData:(NSDictionary *)dic;
@end

@implementation FCClient

@synthesize request;
@synthesize context;
@synthesize hasError;
@synthesize errorMsg;
@synthesize errorDetail;

- (id)initWithTarget:(id)aDelegate action:(SEL)anAction {
	[super initWithDelegate:aDelegate];
	action = anAction;
	hasError = NO;
	return self;
}

- (void)dealloc {
	
	self.hasError =	YES;
	
	errorMsg = nil;
	
	errorDetail = nil;
	
	[super dealloc];
}

#pragma mark alert
- (void)alert {
    /*
     [CommonUtils alert:errorMsg 
     message:errorDetail
     needHotline:NO];
     */
    
}


#pragma mark -
#pragma mark override parent class methods

- (BOOL)checkResponse:(NSHTTPURLResponse *)resp {
	
	return YES;
}

- (void)FCConnectionDidFailWithError:(NSError *)error {
	hasError = YES;
	if (error.code == NSURLErrorUserCancelledAuthentication) {
		statusCode = 401;
		[self authError];
	} else {
		self.errorMsg = NSLocalizedString(kConnFailed, nil);
		self.errorDetail = NSLocalizedString(kNetErrTryAgain, nil);
        [delegate performSelector:action
                       withObject:self
                       withObject:nil];
	}
	
	[self autorelease];
}

- (void)FCConnectionDidFinishLoading:(NSString *)content {
	switch (statusCode) {
		case 401: // Not Authorized: either you need to provide authentication credentials, or the credentials provided aren't valid.
		{
			hasError = YES;
			[self authError];
			
			[self autorelease];
			return;
		}
		case 304: // Not Modified: there was no new data to return.
		{
			[delegate performSelector:action withObject:self withObject:nil];
            [self autorelease];
			return;
		}
        case 400: // Bad Request: your request is invalid, and we'll return an error message that tells you why. This is the status code returned if you've exceeded the rate limit
        case 200: // OK: everything went awesome.
		{
			
			[delegate performSelector:action withObject:self withObject:buf];
			[self autorelease];
			return;
		}
        case 403: // Forbidden: we understand your request, but are refusing to fulfill it.  An accompanying error message should explain why.
            break;
			
        case 404: // Not Found: either you're requesting an invalid URI or the resource in question doesn't exist (ex: no such user). 
        case 500: // Internal Server Error: we did something wrong.  Please post to the group about it and the Twitter team will investigate.
		{
			hasError = YES;
			self.errorMsg = @"No authorization for retrieve post in this class";
			[self autorelease];
			return;
		}
		case 501: // Invalid url parameters
		{
			hasError = YES;
			self.errorMsg = @"Request url parameters invalid";
			self.errorDetail = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
			[self autorelease];
			return;
		}
		case 502: // Bad Gateway: returned if Twitter is down or being upgraded.
        case 503: // Service Unavailable: the Twitter servers are up, but are overloaded with requests.  Try again later.
        default:
		{
			hasError = YES;
			self.errorMsg = @"Server responded with an error";
			self.errorDetail  = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
			//[delegate performSelector:action withObject:self withObject:nil];
			[self autorelease];
			return;
		}
	}
	
	// some special logic
	
	//[self autorelease];
}



#pragma mark get recommend items

- (void)getRecommendItems:(BOOL)isLoadNew groupId:(NSString *)groupId resetGroupType:(NSInteger)resetGroupType orderType:(NSInteger)orderType maxItemId:(NSString *)maxItemId maxCommentTime:(NSTimeInterval)maxCommentTime maxCheckinCount:(NSInteger)maxCheckinCount maxPraiseCount:(NSInteger)maxPraiseCount maxCommentCount:(NSInteger)maxCommentCount {
	
	NSString *url = nil;
	
	
	[self get:url];	
}

#pragma mark - invite people

- (void)invitePeople:(NSString *)url {
    
    [self get:url];
}

//- (NSString *) convertParaToHttpBodyStr:(NSDictionary *)dic {
//    NSArray *keys = [dic allKeys];
//    NSString *res = [NSString string];
//
//    for (int i = 0; i < [keys count]; i++) {
//        res = [res stringByAppendingString:
//               [@"--" stringByAppendingString:
//                [IFACECHINA_FORM_BOUNDARY stringByAppendingString:
//                 [@"\nContent-Disposition: form-data; name=\"" stringByAppendingString:
//                  [[keys objectAtIndex: i] stringByAppendingString:
//                   [@"\"\n\n" stringByAppendingString:
//                    [[dic valueForKey: [keys objectAtIndex:i]] stringByAppendingString:@"\n"]]]]]]]; 
//    } 
//    return res;
//}

- (NSData *)assembleContentData:(NSDictionary *)dic {
    const char chead[] = {-71, -65};
    NSData *headData = [[[NSData alloc] initWithBytes:chead length:2] autorelease];
    const char cfoot[] = {-71, -66};
    NSData *footData = [[[NSData alloc] initWithBytes:cfoot length:2] autorelease];
    
    const char charType[] = {6};
    NSData *typeData = [[[NSData alloc] initWithBytes:charType length:1] autorelease];
    const char cbody[63] = {};
    NSData *bodyData = [[[NSData alloc] initWithBytes:cbody length:63] autorelease];    
    
    NSMutableData *contentData = [NSMutableData data];
    [contentData appendData:headData];
    [contentData appendData:typeData];
    [contentData appendData:bodyData];
    [contentData appendData:footData];
    
    return contentData;
}

//- (NSData *)assembleContentData:(NSDictionary *)dic {
//    NSString *param = [self convertParaToHttpBodyStr:dic];
//    
//    NSMutableData *contentData = [NSMutableData data];
//    
//    
//    [contentData appendData:[param dataUsingEncoding:NSUTF8StringEncoding 
//                                allowLossyConversion:YES]];
//    
//    
//    // append footer
//    NSString *footer = [[NSString alloc] initWithFormat:@"\n--%@--\n", IFACECHINA_FORM_BOUNDARY];
//    [contentData appendData:[footer dataUsingEncoding:NSUTF8StringEncoding
//                                 allowLossyConversion:YES]];
//    
//    
//    [footer release];
//    footer = nil;
//
//    return contentData;
//}

- (void)sendComment {
    
//    const char chead[] = {-71, -65};
//    NSData *headData = [[[NSData alloc] initWithBytes:chead length:2] autorelease];
//    const char cfoot[] = {-71, -66};
//    NSData *footData = [[[NSData alloc] initWithBytes:cfoot length:2] autorelease];
//    
//    const char charType[] = {6};
//    NSData *typeData = [[[NSData alloc] initWithBytes:charType length:1] autorelease];
//    const char cbody[63] = {};
//    NSData *bodyData = [[[NSData alloc] initWithBytes:cbody length:63] autorelease];
    
    
    //    NSLog(@"head: %@", [[[NSString alloc] initWithData:head encoding:NSASCIIStringEncoding] autorelease]);
    
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
    //                         [head bytes], @"SERVER_DATA_HEAD",
    //                         [type bytes], @"REQUEST_TYPE",
    //                         [data bytes], @"requestData",                        
    //                         [foot bytes], @"SERVER_DATA_FOOT", 
    //                         nil];
    
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:head forKey:@"SERVER_DATA_HEAD"];
    //    [dic setObject:type forKey:@"REQUEST_TYPE"];
    //    [dic setObject:data forKey:@"requestData"];
    //    [dic setObject:foot forKey:@"SERVER_DATA_FOOT"];
    
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
    //                         [[[NSString alloc] initWithData:headData encoding:NSUnicodeStringEncoding] autorelease], @"SERVER_DATA_HEAD",
    //                         [[[NSString alloc] initWithData:typeData encoding:NSUnicodeStringEncoding] autorelease], @"REQUEST_TYPE",
    //                         [[[NSString alloc] initWithData:bodyData encoding:NSUnicodeStringEncoding] autorelease], @"requestData",                        
    //                         [[[NSString alloc] initWithData:footData encoding:NSUnicodeStringEncoding] autorelease], @"SERVER_DATA_FOOT", 
    //                         nil];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         headData, @"SERVER_DATA_HEAD",
//                         typeData, @"REQUEST_TYPE",
//                         bodyData, @"requestData",                        
//                         footData, @"SERVER_DATA_FOOT", 
//                         nil];
    
    //    NSString *url = [CommonUtils assembleUrl:nil];
    NSString *url = @"http://www.jitmarketing.cn:188/Default.aspx?user_id=14341&client_id=28&version=3.05&is_need_picture=1&platform=iphone&storage_type=1";
    
    [self post:url data:[self assembleContentData:nil]];
}

@end
