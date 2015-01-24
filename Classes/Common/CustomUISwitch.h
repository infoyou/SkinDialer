#import <UIKit/UIKit.h>


@interface CustomUISwitch : UIControl
{
@private
	BOOL on_;
	UIImageView *bgView_;
}

@property(nonatomic, getter=isOn) BOOL on;

// Overrides initWithFrame: and enforces a size appropriate for the control.
- (id)initWithFrame:(CGRect)frame;

// Set the state of the switch to On or Off, optionally animating the transition.
- (void)setOn:(BOOL)on animated:(BOOL)animated;

- (void)setAlternateColors:(BOOL)alternate;

@end
