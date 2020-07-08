//
//  UIImageView+Extension.m
//  QiaoKeApp
//
//  Created by 郑桂华 on 2020/2/17.
//

#import "UIImageView+FMExtension.h"

@implementation UIImageView (FMExtension)

+ (instancetype)imageViewWithImageName:(NSString *)imageName{
    UIImageView *iv = [[UIImageView alloc] init];
    if (imageName && imageName.length > 0) {
        iv.image = [UIImage imageNamed:imageName];
    }
    return iv;
}

@end
