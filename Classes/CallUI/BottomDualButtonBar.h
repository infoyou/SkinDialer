#import <UIKit/UIKit.h>

@interface BottomDualButtonBar : UIView 
{
@private
  UIButton *_button;
  UIButton *_button2;
  
  UIImage *_background;
}

@property (nonatomic, retain)  UIButton *button;
@property (nonatomic, retain)  UIButton *button2;

- (id) initForIncomingCallWaiting;
- (id) initForEndCall;

@end

