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
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 , width, INT_MAX));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    CFArrayRef rows = CTFrameGetLines(frame);
    // 实际行数
    CFIndex numberOfLines = CFArrayGetCount(rows);
    CFRelease(frame);
    CGPathRelease(Path);
    CFRelease(framesetter);
    return (NSInteger)numberOfLines;
}

@end
