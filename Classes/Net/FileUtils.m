//
//  FileUtils.m
//  iFaceChina
//
//  Created by MobGuang on 10-8-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FileUtils.h"
//#import "ZipArchive.h"



@implementation FileUtils

//static NSString *tmpFileName;

+ (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	return documentsDirectory;
}
/*
+ (void)createFile:(NSString *)fileName fileData:(NSData *)fileData type:(NSInteger)type {


	//------ begin of create local file ---------
	if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
	{
		[[NSFileManager defaultManager] removeItemAtPath:fileName 
												   error:nil];
	}
	[[NSFileManager defaultManager] createFileAtPath:fileName 
											contents:fileData 
										  attributes:nil];
	//------ end of create local file ---------	
	
	
	//--- unzip the file
	NSString *localFileName = nil;
	switch (type) {
		case CLASS_SRC:
		{
			localFileName = [NSString stringWithString:@"classPostsFile"];
			break;
		}
		default:
			break;
	}
	
	tmpFileName = [[self documentsDirectory] stringByAppendingPathComponent:localFileName];	
	
	ZipArchive* zipArchive = [[ZipArchive alloc] init];
	if([zipArchive UnzipOpenFile:fileName])
	{
		BOOL ret = [zipArchive UnzipFileTo:tmpFileName 
								 overWrite:YES];
		if (!ret) {
			debugLog(@"Unzip downloaded file failed");
			goto out;
		}
		[zipArchive UnzipCloseFile];
	} else {
		// this error maybe caused by the zip file be destoried, will try to download it 3 times
		debugLog(@"Opne download file failed due to file be destoried");
		goto out;
	}
	
	
	out:
	[zipArchive release];
	zipArchive = nil;
	 
}
*/



@end
