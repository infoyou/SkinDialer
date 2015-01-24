//
//  ABContentUtil.m
//  SkinDialer
//
//  Created by Adam on 11-6-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ABContentUtil.h"
#import "UnicodePY.h"
#import "Globe.h"

@implementation ABContentUtil

+ (void) addABContentInfo
{
	ABAddressBookRef libroDirec = ABAddressBookCreate();   
	ABRecordRef person = ABPersonCreate();  
	
    ABRecordSetValue(person, kABPersonFirstNameProperty, @"Apple" , nil);  
    ABRecordSetValue(person, kABPersonLastNameProperty, @"IPhone", nil);   
	
	
	ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(multiPhone, @"13524010590", kABPersonPhoneMainLabel, NULL);          
	ABMultiValueAddValueAndLabel(multiPhone, @"18624010590", kABPersonPhoneMobileLabel, NULL);        
	ABRecordSetValue(person, kABPersonPhoneProperty, multiPhone,nil);
	CFRelease(multiPhone);
	
	ABAddressBookAddRecord(libroDirec, person, nil);  
    ABAddressBookSave(libroDirec, nil);  
	
	CFRelease(person);  
}

+ (ABRecordRef)findRecord:(NSString *)phoneNumber
{
    if (phoneNumber == nil)
        return nil;
    
    //ABCGetSharedAddressBook();
    ABAddressBookRef addressBook = ABAddressBookCreate();
    // ABAddressBookFindPersonMatchingPhoneNumber
    ABRecordRef record = ABCFindPersonMatchingPhoneNumber(addressBook, phoneNumber, 0, 0);
    
    return record;
}

+ (NSString*) selNameByNumberFormApi:(NSString*)_callNum
{
	NSLog(@"selNameByNumberFormApi method");
    
    ABRecordRef record;
    record = [self findRecord:_callNum];
    
    if (record) {
        return ABRecordCopyCompositeName(record);
    }else{
        return _callNum;       
    }
}

+ (NSString*) selNameByNumber:(NSString*)_callNum
{
	NSLog(@"selNameByNumber method");
	
	ABAddressBookRef addressBook = ABAddressBookCreate();
	NSMutableArray *peopleArray = (NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	NSLog(@"peopleArray count is %d",[peopleArray count]);
	
	for (id person in peopleArray)
	{
		NSString* firstName= (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSLog(@"First Name is %@",firstName);
		[firstName release];
		
		NSString* lastName= (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
		NSLog(@"Last Name is %@",lastName);
		[lastName release];
		
		ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
		int nCount = ABMultiValueGetCount(phones);
		NSLog(@"Person Phone Count is %d",nCount);
		
		for(int i = 0; i < nCount; i++)
		{
			NSString *phonelLable = (NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
			NSString *phoneNO = (NSString *)ABMultiValueCopyValueAtIndex(phones, i); 
			
            //			NSLog(@"phonelLable is %@, phoneNO is %@",phonelLable,phoneNO);
            phoneNO = [self telFilter:phoneNO];            
            _callNum = [self telFilter:_callNum];
            
			if ([phoneNO hasSuffix: _callNum]) {
				if (firstName && lastName) {
					return [NSString stringWithFormat:@"%@ %@", firstName , lastName];
				}else if (firstName) {
					return firstName;
				}else if (lastName) {
					return lastName;
				}
			}
		}
	}
	
	return _callNum;
}

+ (NSString*) telFilter:(NSString*) phoneNO
{
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"+" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //  NSLog(@"phoneNO is %@",phoneNO);
    return phoneNO;
}

+ (void) selAllABContent
{
	NSLog(@"selABContent method");
	
	ABAddressBookRef addressBook = ABAddressBookCreate();
	NSMutableArray *peopleArray = (NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	NSLog(@"peopleArray count is %d",[peopleArray count]);
	
	for (id person in peopleArray)
	{
		NSString* firstName= (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSLog(@"First Name is %@",firstName);
		[firstName release];
		
		NSString* lastName= (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
		NSLog(@"Last Name is %@",lastName);
		[lastName release];
		
		ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
		int nCount = ABMultiValueGetCount(phones);
		NSLog(@"Person Phone Count is %d",nCount);
		
		for(int i = 0 ;i < nCount;i++)
		{
			NSString *phonelLable    = (NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
			NSString *phoneNO    = (NSString *)ABMultiValueCopyValueAtIndex(phones, i); 
			
			NSLog(@"phonelLable is %@, phoneNO is %@", phonelLable, phoneNO);
		}
	}
}

+ (NSDictionary *) selAllABContentInfo:(NSString *)type
{
	NSLog(@"selAllABContentInfo method");
    
	ABAddressBookRef addressBook = ABAddressBookCreate();
	NSMutableArray *peopleArray = (NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	NSLog(@"peopleArray count is %d",[peopleArray count]);
	
    NSMutableArray *aArray = [[NSMutableArray alloc] init];
    NSMutableArray *bArray = [[NSMutableArray alloc] init];
    NSMutableArray *cArray = [[NSMutableArray alloc] init];
    NSMutableArray *dArray = [[NSMutableArray alloc] init];
    NSMutableArray *eArray = [[NSMutableArray alloc] init];
    NSMutableArray *fArray = [[NSMutableArray alloc] init];
    NSMutableArray *gArray = [[NSMutableArray alloc] init];
    NSMutableArray *hArray = [[NSMutableArray alloc] init];
    NSMutableArray *iArray = [[NSMutableArray alloc] init];
    NSMutableArray *jArray = [[NSMutableArray alloc] init];
    NSMutableArray *kArray = [[NSMutableArray alloc] init];
    NSMutableArray *lArray = [[NSMutableArray alloc] init];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSMutableArray *nArray = [[NSMutableArray alloc] init];
    NSMutableArray *oArray = [[NSMutableArray alloc] init];
    NSMutableArray *pArray = [[NSMutableArray alloc] init];
    NSMutableArray *qArray = [[NSMutableArray alloc] init];
    NSMutableArray *rArray = [[NSMutableArray alloc] init];
    NSMutableArray *sArray = [[NSMutableArray alloc] init];
    NSMutableArray *tArray = [[NSMutableArray alloc] init];
    NSMutableArray *uArray = [[NSMutableArray alloc] init];
    NSMutableArray *vArray = [[NSMutableArray alloc] init];
    NSMutableArray *wArray = [[NSMutableArray alloc] init];
    NSMutableArray *xArray = [[NSMutableArray alloc] init];
    NSMutableArray *yArray = [[NSMutableArray alloc] init];
    NSMutableArray *zArray = [[NSMutableArray alloc] init];
    
    for (id person in peopleArray)
    {
        NSString* firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);            
        NSString* lastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        
        NSString* mkABPersonMiddleNameProperty = (NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty); 
        NSString* mkABPersonPrefixProperty = (NSString *)ABRecordCopyValue(person, kABPersonPrefixProperty);
        NSString* mkABPersonSuffixProperty = (NSString *)ABRecordCopyValue(person, kABPersonSuffixProperty);
        NSString* mkABPersonNicknameProperty = (NSString *)ABRecordCopyValue(person, kABPersonNicknameProperty);
        NSString* mkABPersonFirstNamePhoneticProperty = (NSString *)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
        NSString* mkABPersonLastNamePhoneticProperty = (NSString *)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
        NSString* mkABPersonMiddleNamePhoneticProperty = (NSString *)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
        
        NSMutableString* otherMsg;
        NSMutableString* nameMsg = [[NSMutableString alloc] init];
        
        otherMsg = nil;
        
        if (firstName != nil) {
            [nameMsg appendString:firstName];
        }
        if (lastName != nil) {
            [nameMsg appendString:lastName];
        }
        if (mkABPersonMiddleNameProperty != nil) {
            [nameMsg appendString:mkABPersonMiddleNameProperty];
        }
        if (mkABPersonPrefixProperty != nil) {
            [nameMsg appendString:mkABPersonPrefixProperty];
        }
        if (mkABPersonSuffixProperty != nil) {
            [nameMsg appendString:mkABPersonSuffixProperty];
        }
        if (mkABPersonNicknameProperty != nil) {
            [nameMsg appendString:mkABPersonNicknameProperty];
        }
        if (mkABPersonFirstNamePhoneticProperty != nil) {
            [nameMsg appendString:mkABPersonFirstNamePhoneticProperty];
        }
        if (mkABPersonLastNamePhoneticProperty != nil) {
            [nameMsg appendString:mkABPersonLastNamePhoneticProperty];
        }
        if (mkABPersonMiddleNamePhoneticProperty != nil) {
            [nameMsg appendString:mkABPersonMiddleNamePhoneticProperty];
        }
        
        [nameMsg appendString:KSeparatedFlag];
        
        switch ([type intValue]) {
            case 0:
            {
                // Phone
                ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
                int phonesCount = ABMultiValueGetCount(phones);
                //                NSLog(@"Person Phone Count is %d",phonesCount);
                
                if (phonesCount > 0) {
                    otherMsg = [[NSMutableString alloc] init];
                }
                
                for(int i = 0 ;i < phonesCount;i++)
                {
                    NSString *phoneNO = (NSString*)ABMultiValueCopyValueAtIndex(phones, i);
                    
                    phoneNO = [self telFilter:phoneNO];                    
                    [otherMsg appendString: phoneNO];
                    
                    if (i != phonesCount-1) {
                        [otherMsg appendString:KInviteShowFlag];
                    }
                }
            }
                break;
            case 1:
            {
                // Mail
                ABMultiValueRef mails = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonEmailProperty);
                int mailsCount = ABMultiValueGetCount(mails);
                //  NSLog(@"Person Mails Count is %d",mailsCount);             
                if (mailsCount > 0) {
                    otherMsg = [[NSMutableString alloc] init];
                }
                
                for(int i = 0 ;i < mailsCount;i++)
                {
                    NSString *mailNO = (NSString *)ABMultiValueCopyValueAtIndex(mails, i); 
                    [otherMsg appendString: mailNO];
                    [mailNO release];
                    
                    if (i != mailsCount-1) {
                        [otherMsg appendString:KInviteShowFlag];
                    }
                }
            }
                break;
            default:
                break;
        }
        
        if (!otherMsg) {
            continue;
        }
        
        char mChar;
        mChar = [UnicodePY pinyinFirstLetter:[nameMsg characterAtIndex:0]];
        if (mChar == 'A' || mChar == 'a') {
            [aArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else if (mChar == 'B' || mChar == 'b') {
            [bArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'C' || mChar == 'c') {
            [cArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'D' || mChar == 'd') {
            [dArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'E' || mChar == 'e') {
            [eArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'F' || mChar == 'f') {
            [fArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'G' || mChar == 'g') {
            [gArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'H' || mChar == 'h') {
            [hArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'I' || mChar == 'i') {
            [iArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'J' || mChar == 'j') {
            [gArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'K' || mChar == 'k') {
            [kArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'L' || mChar == 'l') {
            [lArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'M' || mChar == 'm') {
            [mArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'N' || mChar == 'n') {
            [nArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'O' || mChar == 'o') {
            [oArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'P' || mChar == 'p') {
            [pArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'Q' || mChar == 'q') {
            [qArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'R' || mChar == 'r') {
            [rArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'S' || mChar == 's') {
            [sArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'T' || mChar == 't') {
            [tArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'U' || mChar == 'u') {
            [uArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'V' || mChar == 'v') {
            [vArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'W' || mChar == 'w') {
            [wArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'X' || mChar == 'x') {
            [xArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'Y' || mChar == 'y') {
            [yArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
            
        }else  if (mChar == 'Z' || mChar == 'z') {
            [zArray addObject:[NSString stringWithFormat:@"%@ %@",nameMsg,otherMsg]];
        }
        
        [firstName release];
        [lastName release];
        [mkABPersonMiddleNameProperty release]; 
        [mkABPersonPrefixProperty release]; 
        [mkABPersonSuffixProperty release]; 
        [mkABPersonNicknameProperty release]; 
        [mkABPersonFirstNamePhoneticProperty release]; 
        [mkABPersonLastNamePhoneticProperty release]; 
        [mkABPersonMiddleNamePhoneticProperty release]; 
        [nameMsg release];
        if (otherMsg) {
            [otherMsg release];
        }
    }
    
    // NSMutableDictionary
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([aArray count] > 0) {
        [dict setObject:aArray forKey:@"A"];
    } if ([bArray count] > 0) {
        [dict setObject:bArray forKey:@"B"];
    } if ([cArray count] > 0) {
        [dict setObject:cArray forKey:@"C"];
    } if ([dArray count] > 0) {
        [dict setObject:dArray forKey:@"D"];
    } if ([eArray count] > 0) {
        [dict setObject:eArray forKey:@"E"];
    } if ([fArray count]>0) {
        [dict setObject:fArray forKey:@"F"];
    } if ([gArray count] > 0) {
        [dict setObject:gArray forKey:@"G"];
    } if ([hArray count] > 0) {
        [dict setObject:hArray forKey:@"H"];
    } if ([iArray count] > 0) {
        [dict setObject:iArray forKey:@"I"];
    } if ([jArray count]>0) {
        [dict setObject:jArray forKey:@"J"];
    } if ([kArray count] > 0) {
        [dict setObject:kArray forKey:@"K"];
    } if ([lArray count] > 0) {
        [dict setObject:lArray forKey:@"L"];
    } if ([mArray count] > 0) {
        [dict setObject:mArray forKey:@"M"];
    } if ([nArray count] > 0) {
        [dict setObject:nArray forKey:@"N"];
    } if ([oArray count]>0) {
        [dict setObject:oArray forKey:@"O"];
    } if ([pArray count] > 0) {
        [dict setObject:pArray forKey:@"P"];
    } if ([qArray count] > 0) {
        [dict setObject:qArray forKey:@"Q"];
    } if ([rArray count] > 0) {
        [dict setObject:rArray forKey:@"R"];
    } if ([sArray count] > 0) {
        [dict setObject:sArray forKey:@"S"];
    } if ([tArray count]>0) {
        [dict setObject:tArray forKey:@"T"];
    } if ([uArray count] > 0) {
        [dict setObject:uArray forKey:@"U"];
    } if ([vArray count] > 0) {
        [dict setObject:vArray forKey:@"V"];
    } if ([wArray count] > 0) {
        [dict setObject:wArray forKey:@"W"];
    } if ([xArray count] > 0) {
        [dict setObject:xArray forKey:@"X"];
    } if ([yArray count]>0) {
        [dict setObject:yArray forKey:@"Y"];
    } if ([zArray count] > 0) {
        [dict setObject:zArray forKey:@"Z"];
    }
    
    [aArray release];
    [bArray release];
    [cArray release];
    [dArray release];
    [eArray release];
    [fArray release];
    [gArray release];
    [hArray release];
    [iArray release];
    [jArray release];
    [kArray release];
    [lArray release];
    [mArray release];
    [nArray release];
    [oArray release];
    [pArray release];
    [qArray release];
    [rArray release];
    [sArray release];
    [tArray release];
    [uArray release];
    [vArray release];
    [wArray release];
    [xArray release];
    [yArray release];
    [zArray release];
    
    return dict;
}

+ (void)delABContentByName:(NSString *)name
{  
	ABAddressBookRef libroDirec = ABAddressBookCreate();   
	CFArrayRef  allPeople = ABAddressBookCopyArrayOfAllPeople(libroDirec);  
	CFIndex xPeople = ABAddressBookGetPersonCount(libroDirec);  
	
	for (int i=0; i <xPeople; i++ )  
	{  
		ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i);  
		CFStringRef nombreX = ABRecordCopyValue(ref, kABPersonFirstNameProperty);   
		
		CFStringRef cadena = CFSTR("Apple");  
		
		if (CFStringCompare(nombreX, cadena , 0) == kCFCompareEqualTo )  
		{  
			ABAddressBookRemoveRecord(libroDirec, ref, nil);  
			ABAddressBookSave(libroDirec, nil);  
		}  
	}  
}

+ (void)delAllABContent
{  
	ABAddressBookRef libroDirec = ABAddressBookCreate();   
	CFArrayRef  allPeople = ABAddressBookCopyArrayOfAllPeople(libroDirec);  
	CFIndex xPeople = ABAddressBookGetPersonCount(libroDirec);  
	
	for (int i=0; i <xPeople; i++ )  
	{  
		ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i);  
		CFStringRef nombreX = ABRecordCopyValue(ref, kABPersonFirstNameProperty);   		
		ABAddressBookRemoveRecord(libroDirec, ref, nil);  
		ABAddressBookSave(libroDirec, nil);  
	}  
}

+ (ABRecordRef *)selABRecordRefByName:(NSString *)name
{  
	ABAddressBookRef libroDirec = ABAddressBookCreate();   
	CFArrayRef  allPeople = ABAddressBookCopyArrayOfAllPeople(libroDirec);  
	CFIndex xPeople = ABAddressBookGetPersonCount(libroDirec);  
	
	for (int i=0; i <xPeople; i++ )  
	{  
		ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i);  
		CFStringRef nombreX = ABRecordCopyValue(ref, kABPersonFirstNameProperty);   
		
		CFStringRef cadena = CFSTR("Apple");  
		
		if (CFStringCompare(nombreX, cadena , 0) == kCFCompareEqualTo )  
		{  
			//			ABAddressBookRemoveRecord(libroDirec, ref, nil);  
			//			ABAddressBookSave(libroDirec, nil);  
			return ref;
		} 
	}
	return nil;
}

+ (ABRecordRef*) selPersonByNumber:(NSString*)_callNum
{
	NSLog(@"selPersonByNumber method");
	
	ABAddressBookRef addressBook = ABAddressBookCreate();
	NSMutableArray *peopleArray = (NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	NSLog(@"peopleArray count is %d",[peopleArray count]);
	
	for (id person in peopleArray)
	{	
		NSString* firstName= (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSLog(@"First Name is %@",firstName);
		[firstName release];
		
		NSString* lastName= (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
		NSLog(@"Last Name is %@",lastName);
		[lastName release];
		
		ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
		int phonesCount = ABMultiValueGetCount(phones);
		NSLog(@"Person Phone Count is %d",phonesCount);
		
		for(int i = 0 ;i < phonesCount;i++)
		{
			NSString *phonelLable    = (NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
			NSString *phoneNO    = (NSString *)ABMultiValueCopyValueAtIndex(phones, i); 
			
			NSLog(@"phonelLable is %@, phoneNO is %@",phonelLable, phoneNO);
			NSLog(@"_callNum is %@",_callNum);
			
			if ([_callNum isEqualToString: phoneNO]) {
				return person;
			}
		}
	}
	return nil;
}

@end
