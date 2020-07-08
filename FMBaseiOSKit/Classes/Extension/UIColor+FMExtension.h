
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FMExtension)

+ (instancetype)colorWithHex:(uint64_t)hex;
+ (instancetype)colorWithHex:(uint64_t)hex alpha:(CGFloat)alpha;
+ (instancetype)colorWithR:(int)r g:(int)g b:(int)b;
+ (instancetype)colorWithR:(int)r g:(int)g b:(int)b a:(CGFloat)a;
+ (instancetype)randomColor;
@end

NS_ASSUME_NONNULL_END
