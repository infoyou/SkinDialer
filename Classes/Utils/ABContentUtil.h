//
//  ABContentUtil.h
//  SkinDialer
//
//  Created by Adam on 11-6-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ABContentUtil : NSObject {

}

+ (NSString*) telFilter:(NSString*) phoneNO;
+ (NSString*) selNameByNumberFormApi:(NSString*)_callNum;
+ (ABRecordRef*) selPersonByNumber:(NSString*)_callNum;
+ (NSString*) selNameByNumber:(NSString*)_callNum;
+ (NSDictionary *) selAllABContentInfo:(NSString *)type;

@end
