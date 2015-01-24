#import "CallDialerPad.h"

@implementation CallDialerPad
- (UIImage*)keypadImage;
{
	return [UIImage imageNamed: @"callpad"];
}

- (UIImage*)pressedImage
{
	return [UIImage imageNamed: @"callpad_pressed"];
}

- (id)initWithFrame:(struct CGRect)rect
{
  if ((self = [super initWithFrame:rect]) != nil)
  {
    [self setOpaque: TRUE];
	  _topHeight = 58.0;
	  _midHeight = 56.0;
	  _bottomHeight = 59.0;
	  _leftWidth = 95.0;
	  _midWidth = 92.0; // 91
	  _rightWidth = 93.0; // 94	  
  }
  return self;
}

@end
