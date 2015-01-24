#import "BottomButtonBar.h"
#import "BottomBar.h"

@implementation BottomButtonBar

@synthesize button = _button;

+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(UIImage *)image
                              frame:(CGRect)frame
                         background:(UIImage *)backgroundImage
                  backgroundPressed:(UIImage *)backgroundImagePressed
{	
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitle:title forState:UIControlStateNormal];
  button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]]; 
  [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
  [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];

  
  if (image)
  {
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake (0., 0., 0., 5.);
  }
	
	UIImage *newImage = [backgroundImage stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [backgroundImagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
  
  // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
  
	return button;
}

+ (UIImage *)backgroundImage
{
//  UIImage *background = [UIImage imageNamed:@"bottombarred"];
//  NSInteger width = background.size.width;
//  return [background stretchableImageWithLeftCapWidth:width/2 topCapHeight:0.0];
 return [UIImage imageNamed:@"bottombarbkgnd"];
}

+ (UIImageView *)backgroundViewWithRect:(CGRect)aRect
{
  UIImage *background = [UIImage imageNamed:@"bottombarbkgnd"];
  NSInteger width = background.size.width;
  background = [background stretchableImageWithLeftCapWidth:width/2 topCapHeight:0.0];
  
  /*CGRect rect = aRect;
  rect.origin.x -= width;
  rect.size.width += width - 1;*/
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:aRect];
  imageView.image = background;
  imageView.contentMode = UIViewContentModeScaleToFill;
  
  //[self addSubview:imageView];
  //[imageView release];
  return imageView;
}

- (id)initWithDefaultSize
{
  CGRect rect = CGRectMake(DEFAULT_POSX, DEFAULT_POSY, 
                           DEFAULT_WIDTH, DEFAULT_HEIGHT);
  self = [super initWithFrame:rect];
  if (self)
  {
    //[self addBackgroundWithRect:rect];
    rect.origin.y = 0.0;
    [self addSubview:[[BottomButtonBar backgroundViewWithRect:rect] autorelease]];
  }
  return self;
}

- (id) initForEndCall
{
  self = [self initWithDefaultSize];
  if (self)
  {
    UIImage *buttonBackground = [UIImage imageNamed:@"bottombarred"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombarred_pressed"];
    UIImage *image = [UIImage imageNamed:@"decline"];
    
    UIButton *endCall = [BottomButtonBar createButtonWithTitle: NSLocalizedString(@"End", @"PhoneView")
                                                         image: image
                                                         frame: CGRectZero
                                                    background: buttonBackground
                                             backgroundPressed: buttonBackgroundPressed];
    [self setButton:endCall];
  }
  return self;
}

- (id) initForIncomingCallWaiting
{
  self = [self initWithDefaultSize];
  if (self)
  {
    UIImage *buttonBackground = [UIImage imageNamed:@"bottombarred"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombarred_pressed"];
    UIImage *image = [UIImage imageNamed:@"decline"];
    
    UIButton *declineCall = [BottomButtonBar createButtonWithTitle: NSLocalizedString(@"End Call + Answer", @"PhoneView")
                                                             image: image
                                                             frame: CGRectZero
                                                        background: buttonBackground
                                                 backgroundPressed: buttonBackgroundPressed];
    [self setButton:declineCall];
  }
  return self;
}

/*- (void)drawRect:(CGRect)rect 
{
 // Drawing code
  UIImage *bg = [BottomButtonBar backgroundImage];
  NSInteger width = bg.size.width;
  bg = [bg stretchableImageWithLeftCapWidth:width/2 topCapHeight:0.0];
  [bg drawInRect:rect];
}*/


- (void)dealloc 
{
  [_button release];
	[super dealloc];
}

- (void)setButton:(UIButton *)newButton
{
  if (newButton == _button)
    return;
  
  [newButton retain];
  CGRect aRect = CGRectMake(kStdButtonPosX, kStdButtonPosY,
                            kSingleButtonWidth, kStdButtonHeight);
  [newButton setFrame:aRect];
  
  [_button removeFromSuperview];
  [_button release];
  _button = newButton;
  [self addSubview:_button];
}

@end

