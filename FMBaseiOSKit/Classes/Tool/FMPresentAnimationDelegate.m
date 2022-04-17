//
//  FMPresentAnimationDelegate.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/5/23.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import "FMPresentAnimationDelegate.h"
#import "FMTransitionAnimatorFactory.h"

@interface FMPresentAnimationDelegate ()

@property(nonatomic, strong)FMTransitionAnimator *animator;

@end

@implementation FMPresentAnimationDelegate

+ (instancetype)delegateWithAnimator:(FMTransitionAnimator *)animator{
    FMPresentAnimationDelegate *delegate = [[self alloc] init];
    delegate.animator = animator;
    return delegate;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [self.animator open];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [self.animator close];
}

@end
