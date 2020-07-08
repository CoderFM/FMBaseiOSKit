
#import "UIView+FMExtension.h"

@implementation UIView (FMExtension)

+ (instancetype)viewWithBackgroundColor:(UIColor *)bgColor{
    UIView *view = [[self alloc] init];
    view.backgroundColor = bgColor;
    return view;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)setShadowColor:(UIColor *)color{
    [self setShadowColor:color offset:CGSizeMake(0, 0)];
}

- (void)setShadowColor:(UIColor *)color offset:(CGSize)offset{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = 0.3;
}

- (void)setCorner:(UIRectCorner)corner cornerSize:(CGFloat)cornerSize{
    [self setCorner:corner cornerSize:cornerSize forRect:self.bounds];
}

- (void)setCorner:(UIRectCorner)corner cornerSize:(CGFloat)cornerSize forRect:(CGRect)rect{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(cornerSize, cornerSize)].CGPath;
    self.layer.mask = layer;
}

- (void)removeAllSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
