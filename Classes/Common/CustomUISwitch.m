#import "CustomUISwitch.h"
#import <QuartzCore/QuartzCore.h>

#define kSwitchDisplayWidth 94.0
#define kSwitchWidth 149.0
#define kSwitchHeight 27.0

#define kRectOff 		CGRectMake(-55.0, 0.0, kSwitchWidth, kSwitchHeight)
#define kRectOn			CGRectMake(0.0, 0.0, kSwitchWidth, kSwitchHeight)


@interface CustomUISwitch () 

@property (nonatomic, retain, readwrite) UIImageView* bgView;

@end


@implementation CustomUISwitch

@synthesize on = on_;
@synthesize bgView = bgView_;

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 
																						 kSwitchDisplayWidth, kSwitchHeight)])
	{
		self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = 0;
		self.opaque = YES;
		self.layer.cornerRadius = 4.0f;
		
		self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 
																																kSwitchDisplayWidth, kSwitchHeight)];
		[self addSubview:self.bgView];

		self.bgView.image = [UIImage imageNamed:@"switch"];
		self.on = YES;
		
		[self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (void)dealloc
{
	[bgView_ release];
	[super dealloc];
}

- (void)setOn:(BOOL)on
{
	on_ = on;
	self.bgView.frame = self.on ? kRectOn : kRectOff;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
	if (self.on == on)
		return;
	
	if (!animated)
	{
		[self setOn:on];
		return;
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	
	self.bgView.frame = on ? kRectOn : kRectOff;
	
	[UIView commitAnimations];
	on_ = on;
}

- (void)setAlternateColors:(BOOL)alternate
{
	self.bgView.image = (alternate ? [UIImage imageNamed:@"alternate_switch"] :
											 [UIImage imageNamed:@"switch"]);
}

- (void)buttonPressed:(id)target
{
	[self setOn:!self.on animated:YES];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

#if 0
- (void)drawRect:(CGRect)rect
{
}

#pragma mark -
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	BOOL ret = [super beginTrackingWithTouch:touch withEvent:event];
	[self setNeedsDisplay];
	
	return ret;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	BOOL ret = [super continueTrackingWithTouch:touch withEvent:event];

	return ret;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	[self setNeedsDisplay];
}
#endif

@end
