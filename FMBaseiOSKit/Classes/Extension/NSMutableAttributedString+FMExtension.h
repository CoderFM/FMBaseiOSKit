
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (FMExtension)

- (instancetype)addAttr:(NSDictionary *)attr forText:(NSString *)text;
- (instancetype)addAttr:(NSDictionary *)attr range:(NSRange)range;

- (instancetype)addAttr:(NSDictionary *)attr forText:(NSString *)text fromEnd:(BOOL)fromEnd;

- (instancetype)appendImageWithName:(NSString *)imageName font:(UIFont *)font;
- (instancetype)insertImageWithName:(NSString *)imageName font:(UIFont *)font atIndex:(NSUInteger)index;

- (instancetype)setLineSpace:(CGFloat)lineSpace;

@end

NS_ASSUME_NONNULL_END
