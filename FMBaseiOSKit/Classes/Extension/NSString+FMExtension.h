
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FMExtension)

- (NSMutableString *)toMutableString;

- (NSMutableAttributedString *)toAttr;

- (NSMutableAttributedString *)toAttrWithAttr:(NSDictionary *)attr;

- (NSAttributedString *)toHtmlAttr;

- (instancetype)spaceMobile;

- (NSDictionary *)toDictionary;

- (BOOL)isEmpty;

- (BOOL)isHttpUrl;

- (NSInteger)getNumberOfLinesWithAttributes:(NSDictionary *)attributes andLabelWidth:(CGFloat)width;

- (instancetype)beyondLength:(NSInteger)length end:(NSString * __nullable)end;

@end

NS_ASSUME_NONNULL_END
