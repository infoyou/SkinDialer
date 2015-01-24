#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@protocol PhonePadDelegate;

@interface PhonePad : UIControl
{  
	CGFloat _topHeight, _midHeight, _bottomHeight;
	CGFloat _leftWidth, _midWidth, _rightWidth;
	
@private
	id<PhonePadDelegate> _delegate;
	int _downKey;
	
	CFDictionaryRef _keyToRect;
	BOOL _soundsActivated;
}

- (id)initWithFrame:(CGRect)rect;

- (UIImage*)keypadImage;
- (UIImage*)pressedImage;

- (void)handleKeyDown:(id)sender forEvent:(UIEvent *)event;
- (void)handleKeyUp:(id)sender forEvent:(UIEvent *)event;
- (void)handleKeyPressAndHold:(id)sender;
- (int)keyForPoint:(CGPoint)point;
- (CGRect)rectForKey:(int)key;
- (void)drawRect:(CGRect)rect;

- (void)setNeedsDisplayForKey:(int)key;

- (void)setPlaysSounds:(BOOL)activate;
- (void)playSoundForKey:(int)key;

@property (nonatomic, retain) id<PhonePadDelegate> delegate;

@end

@protocol PhonePadDelegate <NSObject>

@optional
- (void)phonePad:(id)phonepad appendString:(NSString *)string;
- (void)phonePad:(id)phonepad replaceLastDigitWithString:(NSString *)string;

- (void)phonePad:(id)phonepad keyDown:(char)car;
- (void)phonePad:(id)phonepad keyUp:(char)car;
@end
