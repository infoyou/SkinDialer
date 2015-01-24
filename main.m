//
//  main.m
//  SkinDialer
//
//  Created by Joseph on 11-5-18.
//  Copyright 2011 iBizChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABContentUtil.h"
#import "UnicodePY.h"

int main(int argc, char *argv[]) {
    
	// 取得用户默认信息
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
	
	// 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    NSLog ( @"%@" , languages); 
    
    //	[ABContentUtil delAllABContent];
    /*
    NSData* returnData;
    returnData = [[NSData alloc] initWithBytes:nil length:63];
    char* bu=[returnData bytes];
    for (int i=0; i<[returnData  length];i++){    
        NSLog(@"打印数据：%d",bu[i]);
    }
    */
    
//    NSLog(@"legth is %d", [temp length]);
//    const char chead[] = {-71, -65};
    char b[2] = {};
    char c[] = {10,20};
    int i;
    
    for(i=0; i<2; i++){
        b[i] = c[i];
     }
    
    NSData *typeData = [[[NSData alloc] initWithBytes:b length:2] autorelease];

    NSLog(@"legth is %@", typeData);
        
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}