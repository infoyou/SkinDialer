//
//  XMLUtils.m
//  iFaceChina
//
//  Created by MobGuang on 10-10-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMLUtils.h"
#import "GlobalConstants.h"
#import "CXMLDocument.h"
#import "CXMLElement.h"
#import "FileUtils.h"

@implementation XMLUtils

#pragma mark entry point

+ (BOOL)parserResponseNode:(NSData *)xmlData doc:(CXMLDocument **)doc {
	NSString *xmlStr = [[NSString alloc] initWithData:xmlData 
                                           encoding:NSUTF8StringEncoding];
	
	NSLog(@"xml string: %@", xmlStr);
	NSRange range = [xmlStr rangeOfString:@"<response>"];
	if (range.length == 0) {
		[xmlStr release];
		xmlStr = nil;
		return NO;
	}
	NSString *contentStr = [xmlStr substringFromIndex:range.location];
	
	[xmlStr release];
	xmlStr = nil;
	//NSLog(@"contentStr: %@", contentStr);
	
	NSError* error = nil;
	*doc = [[CXMLDocument alloc] initWithXMLString:contentStr 
                                         options:0 
                                           error:&error];
	
	if (error || !*doc) {
    return NO;
	}
	
	return YES;
}

+ (BOOL)parserClassesOrGroups:(CXMLDocument *)respDoc MOC:(NSManagedObjectContext *)MOC needSaveIntoDB:(BOOL)needSaveIntoDB groupType:(NSInteger)groupType {
  
	NSArray *groupNodes = [respDoc nodesForXPath:@"//group" 
                                         error:nil];
	
	for (CXMLElement *groupEl in groupNodes) {
		
		/**************************** begin of check current group type *******************************/
		NSInteger currentGroupType;
		NSArray *groupTypes = [groupEl elementsForName:@"group_type"];
		if ([groupTypes count]) {
			currentGroupType = [[[groupTypes lastObject] stringValue] intValue];
		}		
		
		if (groupType != currentGroupType) {
			continue;
		}
		/**************************** end of check current group type *******************************/
		
		//------- begin of check whether same group object has been loaded into core data --------
		NSArray *groupIds = [groupEl elementsForName:@"group_id"];
		long long groupId = 0;
		if ([groupIds count]) {
			groupId = [[[groupIds lastObject] stringValue] longLongValue];
		}
		
		int memberCount = 0;
		NSArray *members = [groupEl elementsForName:@"member_count"];
		if ([members count]) {
			memberCount = [[[members lastObject] stringValue] intValue];
		}
	}
	
	NSError *error = nil;
	if (![MOC save:&error]) {
				return NO;
	}

	return YES;
}

+ (BOOL)handleSyncLoadClassGroups:(CXMLDocument *)respDoc MOC:(NSManagedObjectContext *)MOC {
	NSArray *respCodes = [respDoc nodesForXPath:@"//response/code" 
                                        error:nil];
	
	if ([[[respCodes lastObject] stringValue] caseInsensitiveCompare:kResponseOKCode] == NSOrderedSame) {
		// is ok
		
	} else if ([[[respCodes lastObject] stringValue] caseInsensitiveCompare:@"501"] == NSOrderedSame) {
		// invalide url parameters
		return NO;
	} else if ([[[respCodes lastObject] stringValue] caseInsensitiveCompare:@"500"] == NSOrderedSame) {
		// no authorization for query group in this class
		return NO;
	} else {
		return NO;
	}
	
	return [self parserClassesOrGroups:respDoc MOC:MOC needSaveIntoDB:YES groupType:PUBLIC_GP_TY];
}

+ (BOOL)parserSyncResponseXml:(NSData *)xmlData operationType:(NSInteger)operationType MOC:(NSManagedObjectContext *)MOC {
	CXMLDocument *doc = nil;
	
	if (![self parserResponseNode:xmlData doc:&doc]) {
		return NO;
	}
  
	BOOL ret;
	switch (operationType) {
		case LOAD_CLASS_GROUP_SRC:
			ret = [self handleSyncLoadClassGroups:doc MOC:MOC];
			break;
      
    default:
			break;
	}
	
	[doc release];
	doc = nil;
	
	return ret;
}

+ (BOOL)parserInvitePeopleResult:(NSData *)xmlData sender:(FCClient *)sender {
    CXMLDocument *doc = nil;
	
	if (![self parserResponseNode:xmlData doc:&doc]) {
        // set error message;
        // sender.errorMsg;
        sender.hasError = YES;
        return NO;
	} 
    

    // parser doc, then return result
    NSArray *respCodes = [doc nodesForXPath:@"//response/code" 
                                          error:nil];
    if ([[[respCodes lastObject] stringValue] caseInsensitiveCompare:kResponseOKCode] == NSOrderedSame) {
		// is ok
        NSArray *respDesc = [doc nodesForXPath:@"//response/desc" error:nil];
        sender.errorMsg = [[respDesc lastObject] stringValue];
        return YES;
	} else {
        sender.errorMsg = @"Send Failed";
        sender.hasError = YES;
        return NO;
    }
}

@end
