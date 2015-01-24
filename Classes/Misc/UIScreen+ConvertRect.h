#import <UIKit/UIKit.h>

@interface UIScreen (ConvertRect)

+ (CGRect) convertRect:(CGRect)rect toView:(UIView *)view;

@end
