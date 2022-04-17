//
//  FMTransitionAnimatorFactory.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/9/2.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import "FMTransitionAnimatorFactory.h"

@implementation FMTransitionAnimatorFactory

+ (FMTransitionAnimator *)alphaAnimation{
    FMTransitionAnimator *animator = [[FMTransitionAnimator alloc] init];
    
    animator.openBlock = ^(UIViewController * _Nonnull fromViewController, UIViewController * _Nonnull toViewController, UIView * _Nonnull fromView, UIView * _Nonnull toView, UIView * _Nonnull containerView,NSTimeInterval duration, void (^ _Nonnull complete)(void)) {
        toView.alpha = 0;
        [containerView addSubview:toView];
        [UIView animateWithDuration:duration animations:^{
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            !complete?:complete();
        }];
    };
    
    animator.closeBlock = ^(UIViewController * _Nonnull fromViewController, UIViewController * _Nonnull toViewController, UIView * _Nonnull fromView, UIView * _Nonnull toView, UIView * _Nonnull containerView, NSTimeInterval duration, void (^ _Nonnull complete)(void)) {
        if (![containerView.subviews containsObject:toView]) {
            [containerView insertSubview:toView belowSubview:fromView];
        }
        [UIView animateWithDuration:duration animations:^{
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            !complete?:complete();
        }];
    };
    
    return animator;
}

+ (FMTransitionAnimator *)translateAnimationWithType:(FMTransitionTranslateType)type{
    FMTransitionAnimator *animator = [[FMTransitionAnimator alloc] init];
    
    CGAffineTransform(^getTransform)(UIView *) = ^(UIView *view){
        CGAffineTransform transform;
        switch (type) {
            case FMTransitionTranslateLTR:
                transform = CGAffineTransformMakeTranslation(-view.bounds.size.width, 0);
                break;
            case FMTransitionTranslateRTL:
                transform = CGAffineTransformMakeTranslation(view.bounds.size.width, 0);
                break;
            case FMTransitionTranslateTTB:
                transform = CGAffineTransformMakeTranslation(0, -view.bounds.size.height);
                break;
            case FMTransitionTranslateBTT:
                transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
                break;
        }
        return transform;
    };
    
    animator.openBlock = ^(UIViewController * _Nonnull fromViewController, UIViewController * _Nonnull toViewController, UIView * _Nonnull fromView, UIView * _Nonnull toView, UIView * _Nonnull containerView,NSTimeInterval duration, void (^ _Nonnull complete)(void)) {
        toView.transform = getTransform(toView);
        [containerView addSubview:toView];
        [UIView animateWithDuration:duration animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            !complete?:complete();
        }];
    };
    
    animator.closeBlock = ^(UIViewController * _Nonnull fromViewController, UIViewController * _Nonnull toViewController, UIView * _Nonnull fromView, UIView * _Nonnull toView, UIView * _Nonnull containerView, NSTimeInterval duration, void (^ _Nonnull complete)(void)) {
        if (![containerView.subviews containsObject:toView]) {
            [containerView insertSubview:toView belowSubview:fromView];
        }
        [UIView animateWithDuration:duration animations:^{
            fromView.transform = getTransform(fromView);
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            !complete?:complete();
        }];
    };
    
    return animator;
}



@end
