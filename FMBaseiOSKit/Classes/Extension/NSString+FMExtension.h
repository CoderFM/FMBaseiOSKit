
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FMExtension)

- (NSMutableAttributedString *)toAttr;

- (NSMutableAttributedString *)toAttrWithAttr:(NSDictionary *)attr;

- (NSAttributedString *)toHtmlAttr;

- (instancetype)spaceMobile;

- (NSDictionary *)toDictionary;

- (BOOL)isEmpty;

- (BOOL)isHttpUrl;

- (NSInteger)getNumberOfLinesWithAttributes:(NSDictionary *)attributes andLabelWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
