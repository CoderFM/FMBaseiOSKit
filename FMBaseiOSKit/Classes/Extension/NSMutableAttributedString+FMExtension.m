

#import "NSMutableAttributedString+FMExtension.h"

@implementation NSMutableAttributedString (FMExtension)

- (instancetype)addAttr:(NSDictionary *)attr forText:(NSString *)text{
    return [self addAttr:attr forText:text fromEnd:NO];
}

- (instancetype)addAttr:(NSDictionary *)attr range:(NSRange)range{
    if (self.string.length >= range.location + range.length) {
        [self addAttributes:attr range:range];
    }
    return self;
}

- (instancetype)addAttr:(NSDictionary *)attr forText:(NSString *)text fromEnd:(BOOL)fromEnd{
    if ([self.string containsString:text]) {
        [self addAttributes:attr range:[self.string rangeOfString:text options:fromEnd?NSBackwardsSearch:NSCaseInsensitiveSearch]];
    }
    return self;
}

- (instancetype)appendImageWithName:(NSString *)imageName font:(UIFont *)font{
    if (imageName && imageName.length > 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        [self appendImage:image font:font];
    }
    return self;
}

- (instancetype)insertImageWithName:(NSString *)imageName font:(UIFont *)font atIndex:(NSUInteger)index{
    if (imageName && imageName.length > 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        [self insertImage:image font:font atIndex:index];
    }
    return self;
}

- (instancetype)appendImage:(UIImage *)image font:(UIFont *)font{
    if (image) {
        NSTextAttachment *atta = [[NSTextAttachment alloc] init];
        atta.image = image;
        NSAttributedString *attaAttr = [NSAttributedString attributedStringWithAttachment:atta];
        [self appendAttributedString:attaAttr];
        [self addAttributes:@{NSBaselineOffsetAttributeName:@((font.capHeight - image.size.height) * 0.5)} range:NSMakeRange(self.length - attaAttr.length, attaAttr.length)];
    }
    return self;
}

- (instancetype)insertImage:(UIImage *)image font:(UIFont *)font atIndex:(NSUInteger)index{
    if (image) {
        NSTextAttachment *atta = [[NSTextAttachment alloc] init];
        atta.image = image;
        NSAttributedString *attaAttr = [NSAttributedString attributedStringWithAttachment:atta];
        [self insertAttributedString:attaAttr atIndex:index];
        [self addAttributes:@{NSBaselineOffsetAttributeName:@((font.capHeight - image.size.height) * 0.5)} range:NSMakeRange(index, attaAttr.length)];
    }
    return self;
}

- (instancetype)setLineSpace:(CGFloat)lineSpace{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = lineSpace;
    [self addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, self.length)];
    return self;
}

@end
