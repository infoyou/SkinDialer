#import "LCDView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LCDView

@synthesize displayedName = _label;
@synthesize status = _text;
@dynamic    image;

- (UIImage *)image
{
	return _image.image;
}

- (void) setImage: (UIImage *)image
{
  // TODO Resize text and label if image is defined
	if (image == _image.image)
		return ;

  _image.image = image;

  if (image == nil)
  {
    _label.textAlignment = UITextAlignmentCenter;
    _text.textAlignment = UITextAlignmentCenter;
		_image.hidden = YES;
  }
  else
  {
    _label.textAlignment =  UITextAlignmentLeft;
    _text.textAlignment =  UITextAlignmentLeft;
		_image.hidden = NO;
  }
}


#pragma mark -
- (UILabel *)createLabel:(CGRect)rect size:(CGFloat)fontSize
{
  UILabel *label;
  
  label = [[UILabel alloc] initWithFrame:rect];
  label.backgroundColor = [UIColor clearColor];
  label.adjustsFontSizeToFitWidth = YES;
  label.minimumFontSize = 15;
  label.lineBreakMode = UILineBreakModeHeadTruncation;
  label.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
  label.textAlignment = UITextAlignmentCenter;
  label.textColor = [UIColor whiteColor];
  
  return label;
}

- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
    {
        // Initialization code
      //self.backgroundColor = [UIColor cyanColor];
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lcdbg.png"]];
      //self.alpha = 0.7f;
       
      CGRect rect = frame;
      //rect.size.height = CGRectGetHeight(frame) / 2;
      rect.size.height = CGRectGetHeight(frame) - 30;
      _label = [self createLabel:rect size:32];
      rect.origin.y = CGRectGetHeight(frame) / 2;
      rect.size.height = CGRectGetHeight(frame) / 2;
      _text = [self createLabel:rect size:20];
      
      _image = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 
                                                                 frame.size.height - 10.0f, 
                                                                 frame.size.height - 10.0f)];
      _image.hidden = YES;
      _image.backgroundColor = [UIColor clearColor];
      _image.layer.cornerRadius = 10.0f;
      _image.layer.masksToBounds = YES;
      _image.layer.borderColor = [[UIColor darkGrayColor] CGColor];
      _image.layer.borderWidth = 1;
      //_image.layer.borderWidth = 0;
      
      [self addSubview:_image];
      [self addSubview:_label];
      [self addSubview:_text];
    }
    return self;
}

- (id) initWithDefaultSize
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 320.0f, 96.0f);
  return [self initWithFrame: rect];
}

/*- (void)drawRect:(CGRect)rect {
    // Drawing code
}*/

- (void) setLabel: (NSString *)label
{
	_label.text = label;
}

- (void) setText: (NSString *)text
{
	_text.text = text;
}

- (void)dealloc 
{
	[_label release];
	[_text release];
	[_image release];
	[super dealloc];
}


@end
