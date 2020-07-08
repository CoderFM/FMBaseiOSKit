

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (FMExtension)

- (instancetype)setTextBlack;
- (instancetype)setTextColor:(UIColor *)color;
+ (instancetype)itemWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action congigurationTipLabel:(void(^)(UILabel *))congiguration;
+ (instancetype)itemWithAttributedString:(NSAttributedString *)attributeString target:(nullable id)target action:(nullable SEL)action;
@end

NS_ASSUME_NONNULL_END
