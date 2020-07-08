//
//  UIButton+FMExtension.m
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/19.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "UIButton+FMExtension.h"

@implementation UIButton (FMExtension)

+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UIButton *btn = [[self alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

@end
