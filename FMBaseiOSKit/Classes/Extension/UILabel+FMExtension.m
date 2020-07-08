//
//  UILabel+FMExtension.m
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/19.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "UILabel+FMExtension.h"
#import "NSString+FMExtension.h"
#import <objc/runtime.h>

@implementation UILabel (FMExtension)

+ (void)load{
    {
        Method m1 = class_getInstanceMethod(self, @selector(setText:));
        Method m2 = class_getInstanceMethod(self, @selector(fm_extension_setText:));
        method_exchangeImplementations(m1, m2);
    }
}

- (void)fm_extension_setText:(NSString *)text{
    if (text.isEmpty) {
        text = @"";
    }
    if (![text isKindOfClass:[NSString class]] && ![text isKindOfClass:[NSAttributedString class]] && text != nil) {
        text = [NSString stringWithFormat:@"%@", text];
    }
    [self fm_extension_setText:text];
}

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = font;
    label.textColor = color;
    return label;
}

@end
