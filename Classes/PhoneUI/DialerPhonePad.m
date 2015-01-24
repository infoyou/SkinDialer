#import "DialerPhonePad.h"

@implementation DialerPhonePad
- (UIImage*)keypadImage;
{
	return [UIImage imageNamed: @"dialerkeypad"];
}

- (UIImage*)pressedImage
{
	return [UIImage imageNamed: @"dialerkeypad_pressed"];
}

- (id)initWithFrame:(struct CGRect)rect
{
  if ((self = [super initWithFrame:rect]) != nil)
  {
    [self setOpaque: TRUE];
    _topHeight = 69.0;
    _midHeight = 68.0;
    _bottomHeight = 68.0;
    _leftWidth = 107.0;
    _midWidth = 105.0;
    _rightWidth = 108.0;
  }
  return self;
}

@end
