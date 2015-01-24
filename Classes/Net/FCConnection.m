//
//  FCConnection.m
//  iFaceChina
//
//  Created by MobGuang on 10-8-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FCConnection.h"
#import "GlobalConstants.h"

#define NETWORK_TIMEOUT 60.0

@implementation FCConnection

@synthesize buf;
@synthesize statusCode;
@synthesize requestUrl;

- (id)initWithDelegate:(id)aDelegate {
	self = [super init];
	delegate = aDelegate;
	statusCode = 0;
	needAuth = NO;
	return self;
}

- (void)dealloc {
	[requestUrl release];
	requestUrl = nil;
	
	if (connection) {
		[connection release];
		connection = nil;
	}
	[buf release];
	buf = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark local methods that maybe be override by subclass

- (void)addAuthHeader:(NSMutableURLRequest *)req {
	if (!needAuth) {
		return;
	}
	
	/*
	NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:kUsername];
	NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
	NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kPassword];
	 */
	
	//TODO check username and password
}

- (void)get:(NSString *)aUrl {
	if (connection) {
		[connection release];
		connection = nil;		
	}
	
	if (buf) {
		[buf release];
		buf = nil;		
	}
	statusCode = 0;
	
	// if aUrl is nil, which means the connection is unavailable now, a message will be displayed for user
	self.requestUrl = aUrl;
	
	NSString *url = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aUrl, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
	
	[url autorelease];
	
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
													   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
												   timeoutInterval:NETWORK_TIMEOUT];
	//[req setHTTPMethod:kGet];
	//[self addAuthHeader:req];
	
	buf = [[NSMutableData data] retain];
	connection = [[NSURLConnection alloc] initWithRequest:req 
												 delegate:self];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)post:(NSString *)aUrl data:(NSData *)data {
	if (connection) {
		[connection release];
		connection = nil;		
	}
	
	if (buf) {
		[buf release];
		buf = nil;		
	}

	statusCode = 0;
	
	if (aUrl == nil) {
		// set a temp url, then force the operation failed, the notification will be 
		// displayed for user if necessary
		aUrl = @"www.ifacechina.com";
	}
	
	self.requestUrl = aUrl;
	
	NSString *url = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aUrl, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
	[url autorelease];
	
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
													   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                   timeoutInterval:NETWORK_TIMEOUT];
	
//	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", IFACECHINA_FORM_BOUNDARY];
	[req setHTTPMethod:kPost];
//	[req setValue:contentType forHTTPHeaderField:kHttpHeaderFieldType];
	NSString *tmpValue = [[NSString alloc] initWithFormat:@"%d", [data length]];
	[req setValue:tmpValue forHTTPHeaderField:kHttpHeaderFieldLength];
	
	[req setHTTPBody:data];
	[self addAuthHeader:req];
	
	[tmpValue release];
	tmpValue = nil;
	
	buf = [[NSMutableData data] retain];
	connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)post:(NSString *)aUrl body:(NSString *)body {
	if (connection) {
		[connection release];
		connection = nil;		
	}
	
	if (buf) {
		[buf release];
		buf = nil;		
	}
	statusCode = 0;
	
	if (aUrl == nil) {
		// set a temp url, then force the operation failed, the notification will be 
		// displayed for user if necessary
		aUrl = @"www.ifacechina.com";
	}
	
	self.requestUrl = aUrl;
	
	NSString *url = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aUrl, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
	[url autorelease];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] 
													   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
												   timeoutInterval:NETWORK_TIMEOUT];
	[req setHTTPMethod:kPost];
	[req setValue:kFormAuthValue 
forHTTPHeaderField:kHttpHeaderFieldType];
	
	[self addAuthHeader:req];
	
	int contentLength = [body lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	
	[req setValue:[NSString stringWithFormat:@"%d", contentLength] forHTTPHeaderField:kHttpHeaderFieldLength];
	[req setHTTPBody:[NSData dataWithBytes:[body UTF8String] 
									length:contentLength]];
	
	buf = [[NSMutableData data] retain];
	connection = [[NSURLConnection alloc] initWithRequest:req 
												 delegate:self];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)cancel {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	if (connection) {
		[connection cancel];
		[connection autorelease];
		connection = nil;
	}
}

- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data {
	[buf appendData:data];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse {
 	NSHTTPURLResponse *resp = (NSHTTPURLResponse *)aResponse;
		
	if (resp) {
		statusCode = resp.statusCode;
	}
	[buf setLength:0];
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	[connection autorelease];
	connection = nil;
	[buf autorelease];
	buf = nil;
	
	NSString *msg = [NSString stringWithFormat:@"Error: %@ %@",
                     [error localizedDescription],
                     [[error userInfo] objectForKey:NSErrorFailingURLStringKey]];

	[self FCConnectionDidFailWithError:error];
}

- (BOOL)checkResponse:(NSHTTPURLResponse *)resp {
	// To be implemented in subclass to check the response, e.g., check the signup result
    return YES;
}

- (void)FCConnectionDidFailWithError:(NSError *)error {
	// To be implemented in subclass
}


- (void)connectionDidFinishLoading:(NSURLConnection *)aConn {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSString *str = [[[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding] autorelease];
	
	[self FCConnectionDidFinishLoading:str];
	
	[connection autorelease];
	connection = nil;
	[buf autorelease];
	buf = nil;
}

- (void)FCConnectionDidFinishLoading:(NSString *)content {
	// To be implemented in subclass
}

@end
