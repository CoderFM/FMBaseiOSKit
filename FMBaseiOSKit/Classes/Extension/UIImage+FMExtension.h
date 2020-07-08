

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FMExtension)
+ (instancetype)imageWithColor:(UIColor *)color;
- (instancetype)fillSize:(CGSize)size;
- (NSData *)dataCompressMaxSize:(NSInteger)maxSize;
@end

NS_ASSUME_NONNULL_END
