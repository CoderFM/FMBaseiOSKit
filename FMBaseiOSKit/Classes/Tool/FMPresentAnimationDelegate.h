//
//  FMPresentAnimationDelegate.h
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/5/23.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FMTransitionAnimator;
@interface FMPresentAnimationDelegate : NSObject<UIViewControllerTransitioningDelegate>

+ (instancetype)delegateWithAnimator:(FMTransitionAnimator *)animator;

@end

NS_ASSUME_NONNULL_END
