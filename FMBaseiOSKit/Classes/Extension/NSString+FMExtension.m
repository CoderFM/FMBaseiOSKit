

#import "NSString+FMExtension.h"

@implementation NSString (FMExtension)

- (NSMutableAttributedString *)toAttr{
    return [[NSMutableAttributedString alloc] initWithString:self];
}
- (NSMutableAttributedString *)toAttrWithAttr:(NSDictionary *)attr{
    return [[NSMutableAttributedString alloc] initWithString:self attributes:attr];
}

- (NSAttributedString *)toHtmlAttr{
    NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attr;
}

- (instancetype)spaceMobile{
    if (self.length != 11) {
        return self;
    }
    NSMutableString *phoneStr = [self mutableCopy];
    [phoneStr insertString:@" " atIndex:3];
    [phoneStr insertString:@" " atIndex:8];
    return phoneStr;
}

- (NSDictionary *)toDictionary{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
}

- (BOOL)isEmpty{
    return self.length == 0 || [self isKindOfClass:[NSNull class]] || self == nil;
}

- (BOOL)isHttpUrl{
    if ([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

@end
