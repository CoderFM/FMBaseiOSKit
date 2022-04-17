//
//  FMTransitionAnimatorFactory.h
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/9/2.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FMTransitionTranslateType) {
    FMTransitionTranslateLTR,
    FMTransitionTranslateRTL,
    FMTransitionTranslateTTB,
    FMTransitionTranslateBTT,
};

@interface FMTransitionAnimatorFactory : NSObject

+ (FMTransitionAnimator *)alphaAnimation;

+ (FMTransitionAnimator *)translateAnimationWithType:(FMTransitionTranslateType)type;

@end

NS_ASSUME_NONNULL_END
