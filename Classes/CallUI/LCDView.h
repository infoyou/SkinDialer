#import <UIKit/UIKit.h>


@interface LCDView : UIView 
{
@private
  UILabel     *_label;
  UILabel     *_text;
  UIImageView *_image;
}

@property (nonatomic, readonly) UILabel *displayedName;
@property (nonatomic, readonly) UILabel *status;
@property (nonatomic, retain)   UIImage *image;

- (id) initWithDefaultSize;
- (void) setLabel: (NSString *)label;
- (void) setText: (NSString *) text;
- (void) setSubImage: (UIImage *) image;
@end
