//
//  FMBaseAlertView.h
//  FMBaseKit
//
//  Created by 郑桂华 on 2020/6/15.
//

#import "FMBasePopupView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FMAlertType) {
    /// 来源下方
    FMAlertTypeBottom,
    /// 来源左边
    FMAlertTypeLeft,
    /// 来源右边
    FMAlertTypeRight,
    /// 来源上边
    FMAlertTypeTop,
};

@interface FMBaseAlertView : FMBasePopupView

@property(nonatomic, weak)UIView *triangleView;

@property(nonatomic, assign)CGSize triangleSize;

@property(nonatomic, assign)UIEdgeInsets contentInset;

+ (instancetype)showToView:(UIView *)view from:(UIView *)from contentSize:(CGSize)size type:(FMAlertType)type;
+ (instancetype)showToView:(UIView *)view fromPoint:(CGPoint)fromPoint contentSize:(CGSize)size type:(FMAlertType)type;

@end

NS_ASSUME_NONNULL_END
