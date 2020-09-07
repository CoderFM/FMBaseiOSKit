

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FMExtension)

@property(readonly)UIImage *originalImage;

+ (instancetype)imageWithColor:(UIColor *)color;
- (instancetype)fillSize:(CGSize)size;
- (NSData *)dataCompressMaxSize:(NSInteger)maxSize;
+ (instancetype)imageWithAttributes:(NSAttributedString *)attributes;
+ (instancetype)imageWithAttributes:(NSAttributedString *)attributes inset:(UIEdgeInsets)inset;
+ (instancetype)imageWithAttributes:(NSAttributedString *)attributes inset:(UIEdgeInsets)inset borderWidth:(CGFloat)borderWidth borderColor:(UIColor * __nullable)borderColor cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor * __nullable)bgColor;
@end

NS_ASSUME_NONNULL_END
