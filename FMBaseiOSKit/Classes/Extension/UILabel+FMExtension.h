//
//  UILabel+FMExtension.h
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/19.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FMExtension)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
