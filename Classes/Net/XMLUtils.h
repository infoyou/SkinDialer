//
//  XMLUtils.h
//  iFaceChina
//
//  Created by MobGuang on 10-10-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMLDocument.h"
#import <CoreData/CoreData.h>
#import "FCClient.h"


@interface XMLUtils : NSObject {
	
}
+ (BOOL)parserSyncResponseXml:(NSData *)xmlData operationType:(NSInteger)operationType MOC:(NSManagedObjectContext *)MOC;

+ (BOOL)parserInvitePeopleResult:(NSData *)xmlData sender:(FCClient *)sender;
@end
