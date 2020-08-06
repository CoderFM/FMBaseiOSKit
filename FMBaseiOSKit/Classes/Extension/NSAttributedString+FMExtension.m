//
//  NSAttributedString+FMExtension.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/20.
//

#import "NSAttributedString+FMExtension.h"
#import <CoreText/CoreText.h>

@implementation NSAttributedString (FMExtension)

- (NSInteger)getNumberOfLinesWithWidth:(CGFloat)width{
    CFRange range = CFRangeMake(0, 0);
    CGFloat height = MAXFLOAT;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 , width, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, range, Path, NULL);
    CFArrayRef rows = CTFrameGetLines(frame);
    CFIndex numberOfLines = CFArrayGetCount(rows);
    CFRelease(frame);
    CGPathRelease(Path);
    CFRelease(framesetter);
    return (NSInteger)numberOfLines;
}

- (NSArray *)getRectsWithWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight limitLine:(NSInteger)limitLine fromRange:(NSRange)fromRange{
    CGFloat height = maxHeight;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 , width, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    CFArrayRef rows = CTFrameGetLines(frame);
    // 实际行数
    CFIndex numberOfLines = CFArrayGetCount(rows);
    // 获取行的原点
    CGPoint origins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    NSMutableArray *rects = [NSMutableArray array];
    for (int i = 0; i < numberOfLines; i++) {
        if (i >= limitLine) {
            break;
        }
        // 拿到每一行的对象
        CTLineRef line = CFArrayGetValueAtIndex(rows, i);
        // 该行文本范围
        CFRange range = CTLineGetStringRange(line);
        
        if (range.location + range.length > fromRange.location && range.location < fromRange.location + fromRange.length) {
            // 高度矫正
            CGFloat ascent, descent;
            CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
            CGPoint lineOrigin = origins[i];
            
            NSInteger startIndex;
            NSInteger textLength;
            if (range.location < fromRange.location && range.location + range.length > fromRange.location) {
                startIndex = fromRange.location;
            } else {
                startIndex = range.location;
            }
            textLength = MIN(range.location + range.length, fromRange.location + fromRange.length) - startIndex;
            CGFloat offsetY = height - lineOrigin.y + descent - ascent;
            CGFloat offsetX = CTLineGetOffsetForStringIndex(line, startIndex, nil);
            NSRange currentRange = NSMakeRange(startIndex, textLength);
            
            NSAttributedString *lineAttr = [self attributedSubstringFromRange:NSMakeRange(range.location, range.length)];
            CGFloat height = [lineAttr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
            NSAttributedString *subAttr = [self attributedSubstringFromRange:currentRange];
            CGFloat width = [subAttr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
            CGRect rect = CGRectMake(offsetX, offsetY, width, height);
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
    }
    CFRelease(frame);
    CGPathRelease(Path);
    CFRelease(framesetter);
    return rects;
}

- (void)asyncGetRectsWithWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight limitLine:(NSInteger)limitLine fromRange:(NSRange)fromRange complete:(void(^)(NSArray *))complete{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *rects = [self getRectsWithWidth:width maxHeight:maxHeight limitLine:limitLine fromRange:fromRange];
        !complete?:complete(rects);
    });
}

@end
