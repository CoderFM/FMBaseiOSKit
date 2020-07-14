

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FMExtension)
///在主屏幕上的frame
@property(readonly)CGRect globalFrame;
///origin在主屏幕上的位置
@property(readonly)CGPoint globalOrigin;
///中心点在主屏幕上的位置
@property(readonly)CGPoint globalCenter;

+ (instancetype)viewWithBackgroundColor:(UIColor *)bgColor;

/**
 * 设置圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;
/**
 * 设置边框
 */
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color;

- (void)setShadowColor:(UIColor *)color;
- (void)setShadowColor:(UIColor *)color offset:(CGSize)offset;

- (void)setCorner:(UIRectCorner)corner cornerSize:(CGFloat)cornerSize;
- (void)setCorner:(UIRectCorner)corner cornerSize:(CGFloat)cornerSize forRect:(CGRect)rect;
/**
 * 移除所有子z视图
 */
- (void)removeAllSubviews;

@end

NS_ASSUME_NONNULL_END
