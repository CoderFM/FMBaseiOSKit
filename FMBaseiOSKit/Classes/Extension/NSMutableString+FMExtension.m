//
//  NSMutableString+FMExtension.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/3.
//

#import "NSMutableString+FMExtension.h"

@implementation NSMutableString (FMExtension)

- (instancetype)append:(NSString *)text{
    [self appendString:text];
    return self;
}
- (instancetype)inset:(NSString *)text index:(NSInteger)index{
    [self insertString:text atIndex:index];
    return self;
}
- (instancetype)replace:(NSString *)text forRange:(NSRange)range{
    [self replaceCharactersInRange:range withString:text];
    return self;
}
- (instancetype)replace:(NSString *)text forText:(NSString *)forText{
    NSRange range = [self rangeOfString:forText];
    if (range.location != NSNotFound) {
        [self replaceCharactersInRange:range withString:text];
    }
    return self;
}

@end
