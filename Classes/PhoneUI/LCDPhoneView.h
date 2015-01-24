#import <UIKit/UIKit.h>


@interface LCDPhoneView : UIView 
{
@private
  UILabel *_topLabel;
  UILabel *_leftLabel;
  UILabel *_rightLabel;
  UIScrollView *_scrollView;
}

- (void)topText:(NSString *)text;
- (void)rightText:(NSString *)text;
- (void)leftText:(NSString *)text;

@end
