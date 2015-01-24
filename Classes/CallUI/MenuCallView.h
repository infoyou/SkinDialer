#import <UIKit/UIKit.h>
#import "PushButton.h"

@protocol MenuCallViewDelegate;

@interface MenuCallView : UIView 
{
	@private
  PushButton *_buttons[6];
  id<MenuCallViewDelegate> delegate;
	
	BOOL consumedTap_;
}

@property (nonatomic, retain)  id<MenuCallViewDelegate> delegate;

- (PushButton *)buttonAtPosition:(NSInteger)button;
- (void)setTitle:(NSString *)title image:(UIImage *)image forPosition:(NSInteger)pos;

@end

@protocol MenuCallViewDelegate <NSObject>
- (void)menuButtonClicked:(NSInteger)button;
@optional
- (void)menuButtonHeldDown:(NSInteger)button;
@end
