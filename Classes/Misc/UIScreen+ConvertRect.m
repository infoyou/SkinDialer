#import <UIKit/UIKit.h>

#import "UIScreen+ConvertRect.h"


@implementation UIScreen (ConvertRect)

+ (CGRect) convertRect:(CGRect)rect toView:(UIView *)view 
{
	UIWindow *window = [view isKindOfClass:[UIWindow class]] ? (UIWindow *) view : [view window];
	return [view convertRect:[window convertRect:rect fromWindow:nil] fromView:nil];
}


@end
