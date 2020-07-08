

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMNoneDataView : UIView
@property(nonatomic, weak)UIImageView *nonImageView;
@property(nonatomic, weak)UILabel *nonTextLabel;
@property(nonatomic, weak)UIButton *nonButton;
- (void)setImage:(UIImage *)image text:(NSString *)text;
- (void)imageOffsetCenterY:(CGFloat)offsetY;
@end

NS_ASSUME_NONNULL_END
