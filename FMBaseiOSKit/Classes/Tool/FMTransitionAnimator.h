//
//  FMTransitionAnimator.h
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/8/28.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FMTransitionAnimationBlock)(UIViewController *fromViewController, UIViewController *toViewController, UIView *fromView, UIView *toView, UIView *containerView, NSTimeInterval duration, void(^complete)(void));

@interface FMTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, copy)FMTransitionAnimationBlock openBlock;
@property(nonatomic, copy)FMTransitionAnimationBlock closeBlock;

@property(nonatomic, assign)NSTimeInterval duration;

- (instancetype)open;
- (instancetype)close;

@end

NS_ASSUME_NONNULL_END
