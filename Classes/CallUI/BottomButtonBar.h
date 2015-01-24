#import <UIKit/UIKit.h>

@interface BottomButtonBar : UIView 
{
@private
  UIButton *_button;
}

@property (nonatomic, retain)  UIButton *button;

- (id) initForIncomingCallWaiting;
- (id) initForEndCall;

+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(UIImage *)image
                              frame:(CGRect)frame
                         background:(UIImage *)backgroundImage
                  backgroundPressed:(UIImage *)backgroundImagePressed;

+ (UIImageView *)backgroundViewWithRect:(CGRect)aRect;
+ (UIImage *)backgroundImage;

@end
