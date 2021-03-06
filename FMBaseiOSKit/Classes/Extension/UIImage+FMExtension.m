

#import "UIImage+FMExtension.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (FMExtension)

- (UIImage *)originalImage{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithColor:(UIColor *)color{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.backgroundColor = color;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [view removeFromSuperview];

    return image;
}

- (instancetype)fillSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//先调整分辨率，分辨率可以自己设定一个值，大于的就缩小到这分辨率，小余的就保持原本分辨率。然后在判断图片数据大小，传入范围maxSize = 100 ，大于的再压缩，小的就保持原样
- (NSData *)dataCompressMaxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(self.size.width, self.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(self.size.width / tempWidth, self.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(self.size.width / tempHeight, self.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

+ (instancetype)imageWithAttributes:(NSAttributedString *)attributes{
    return [self imageWithAttributes:attributes inset:UIEdgeInsetsZero];
}

+ (instancetype)imageWithAttributes:(NSAttributedString *)attributes inset:(UIEdgeInsets)inset{
    return [self imageWithAttributes:attributes inset:inset borderWidth:0 borderColor:nil cornerRadius:0 backgroundColor:nil];
}

+ (instancetype)imageWithAttributes:(NSAttributedString *)attributes inset:(UIEdgeInsets)inset borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor * __nullable)bgColor{
    
    CGSize attrSize = [attributes boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGSize imageSize = CGSizeMake(inset.left + attrSize.width + inset.right, inset.top + attrSize.height + inset.bottom);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [attributes drawAtPoint:CGPointMake(inset.left, inset.top)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText = attributes;
    [view addSubview:label];
    
    view.layer.cornerRadius = cornerRadius;

    if (bgColor) {
        view.backgroundColor = bgColor;
        if (cornerRadius > 0) {
            view.layer.masksToBounds = YES;
        }
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = borderWidth;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    [view removeFromSuperview];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage*)coverImageForVideo:(NSURL *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    
    return thumbImg;
}

@end
