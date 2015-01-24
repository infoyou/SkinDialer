//
//  WebView.h
//  SkinDialer
//
//  Created by Adam on 11-7-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebView : UIViewController<UIWebViewDelegate> {
    NSString *strUrl;
}

@property (nonatomic,retain) NSString *strUrl;

@end
