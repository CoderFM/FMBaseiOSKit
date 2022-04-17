//
//  FMTransitionAnimator.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/8/28.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import "FMTransitionAnimator.h"

typedef NS_ENUM(NSUInteger, FMTransitionType) {
    FMTransitionTypeOpen,
    FMTransitionTypeClose,
};

@interface FMTransitionAnimator ()

@property(nonatomic, assign)FMTransitionType type;

@end

@implementation FMTransitionAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.25;
    }
    return self;
}

- (instancetype)open{
    self.type = FMTransitionTypeOpen;
    return self;
}

- (instancetype)close{
    self.type = FMTransitionTypeClose;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    switch (self.type) {
        case FMTransitionTypeOpen:
        {
            if (self.openBlock) {
                self.openBlock(fromViewController, toViewController, fromView, toView, containerView, duration,^{
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!isCancelled];
                });
            }
        }
            break;
        case FMTransitionTypeClose:
        {
            if (self.closeBlock) {
                self.closeBlock(fromViewController, toViewController, fromView, toView, containerView, duration, ^{
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!isCancelled];
                });
            }
        }
            break;
    }
}

@end
