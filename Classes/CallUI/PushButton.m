#import "PushButton.h"


@implementation PushButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
  return _contentRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
	CGRect rect = _contentRect;
	
	rect.origin.x -= 9.0;
	rect.size.width += 18.0;
	
	rect.origin.y = rect.size.height;
	rect.size.height = [UIFont buttonFontSize];
	
	return rect;
}

- (CGRect)contentRectForBounds:(CGRect)bounds
{
  return _contentRect;
}

- (void)dealloc 
{
  //[_contentRect release];
  [super dealloc];
}

- (void)setContentRect:(CGRect)rect
{
  //[_contentRect release];
  _contentRect = rect;
}

@end
