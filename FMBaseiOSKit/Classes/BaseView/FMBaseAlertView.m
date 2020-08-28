//
//  FMBaseAlertView.m
//  FMBaseKit
//
//  Created by 郑桂华 on 2020/6/15.
//

#import "FMBaseAlertView.h"
#import <Masonry/Masonry.h>
#import "FMConfig.h"

@interface FMBaseAlertView ()

@end

@implementation FMBaseAlertView

+ (instancetype)showToView:(UIView *)view fromPoint:(CGPoint)fromPoint contentSize:(CGSize)size type:(FMAlertType)type{
    FMBaseAlertView *alert = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alert.animationDamping = 1;
    alert.hidden = YES;
    [view addSubview:alert];
    CGFloat height = size.height;
    CGFloat width = size.width;
    CGPoint point = fromPoint;
    CGFloat screenHeight = [FMConfig config].screenHeight;
    CGFloat screenWidth = [FMConfig config].screenWidth;
    CGFloat statusHeight = [FMConfig config].statusHeight;
    CGFloat bottomHeight = [FMConfig config].safeBottomHeight;
    if (type == FMAlertTypeLeft || type == FMAlertTypeRight) {
        CGFloat centerY = point.y - screenHeight * 0.5;
        CGFloat triangleCenterY = 0;
        if (point.y < statusHeight + height * 0.5) {
            triangleCenterY = point.y - (statusHeight + height * 0.5);
        }
        if (point.y > screenHeight - bottomHeight - height * 0.5) {
            triangleCenterY = point.y - (screenHeight - bottomHeight - height * 0.5);
        }
        CGFloat minCenterY = - screenHeight * 0.5 + statusHeight + height * 0.5 + alert.contentInset.top;
        CGFloat maxCenterY = screenHeight * 0.5 - height * 0.5 - bottomHeight - alert.contentInset.bottom;
        if (centerY < minCenterY) {
            centerY = minCenterY;
        }
        if (centerY > maxCenterY) {
            centerY = maxCenterY;
        }
        [alert.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            if (type == FMAlertTypeLeft) {
                make.right.mas_equalTo(-(screenWidth - point.x + 20));
            } else {
                make.left.mas_equalTo(point.x + 20);
            }
            make.centerY.mas_equalTo(centerY);
        }];
        if (type == FMAlertTypeRight) {
            alert.triangleView.transform = CGAffineTransformMakeRotation(M_PI);
        }
        [alert.triangleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(triangleCenterY);
            if (type == FMAlertTypeLeft) {
                make.left.mas_equalTo(alert.contentView.mas_right);
            } else {
                make.right.mas_equalTo(alert.contentView.mas_left);
            }
            make.width.mas_equalTo(alert.triangleSize.width);
            make.height.mas_equalTo(alert.triangleSize.height);
        }];
    } else {
        CGFloat centerX = point.x - screenWidth * 0.5;
        CGFloat triangleCenterX = 0;
        if (point.x < width * 0.5) {
            triangleCenterX = point.x - (width * 0.5);
        }
        if (point.x > screenWidth - width * 0.5) {
            triangleCenterX = point.x - (screenWidth - height * 0.5);
        }
        CGFloat minCenterX = - screenWidth * 0.5 + width * 0.5 + alert.contentInset.left;
        CGFloat maxCenterX = screenWidth * 0.5 - width * 0.5 - alert.contentInset.right;
        if (centerX < minCenterX) {
            centerX = minCenterX;
        }
        if (centerX > maxCenterX) {
            centerX = maxCenterX;
        }
        [alert.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width);
            make.height.mas_equalTo(height);
            if (type == FMAlertTypeTop) {
                make.bottom.mas_equalTo(-(screenHeight - point.y + 20));
            } else {
                make.top.mas_equalTo(point.y + 20);
            }
            make.centerX.mas_equalTo(centerX);
        }];
        alert.triangleView.transform = CGAffineTransformMakeRotation(type == FMAlertTypeTop ? M_PI_2 : -M_PI_2);
        [alert.triangleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(triangleCenterX);
            if (type == FMAlertTypeTop) {
                make.top.mas_equalTo(alert.contentView.mas_bottom).offset(-(alert.triangleSize.height - alert.triangleSize.width) * 0.5);
            } else {
                make.bottom.mas_equalTo(alert.contentView.mas_top).offset((alert.triangleSize.height - alert.triangleSize.width) * 0.5);
            }
            make.width.mas_equalTo(alert.triangleSize.width);
            make.height.mas_equalTo(alert.triangleSize.height);
        }];
    }
    
    [alert layoutIfNeeded];
    [alert animationShow];
    return alert;
}

+ (instancetype)showToView:(UIView *)view from:(UIView *)from contentSize:(CGSize)size type:(FMAlertType)type{
    return [self showToView:view fromPoint:[from.superview convertPoint:from.center toView:view] contentSize:size type:type];
}

- (UIView *)triangleView{
    if (_triangleView == nil) {
        CGSize triangleSize = self.triangleSize;
        UIView *triangleView = [[UIView alloc] init];
        triangleView.backgroundColor = self.contentView.backgroundColor;
        [self.contentView addSubview:triangleView];
        _triangleView = triangleView;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(triangleSize.width, triangleSize.height * 0.5)];
        [path addLineToPoint:CGPointMake(0, triangleSize.height)];
        [path closePath];
        layer.path = path.CGPath;
        triangleView.layer.mask = layer;
    }
    return _triangleView;
}

- (CGAffineTransform)animationTransform{
    return CGAffineTransformMakeScale(0.1, 0.1);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.animationDamping = 0.7;
        self.animationVelocity = 20;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(400);
        }];
        
        self.triangleSize = CGSizeMake(10, 20);
        self.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

- (void)animationHidden:(void (^)(void))complete{
    self.hidden = YES;
    !complete?:complete();
}

@end
