//
//  FMFloatContainerController.h
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2022/4/16.
//  Copyright © 2022 zhoufaming251@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTransitionAnimatorFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMFloatShowConfig : NSObject

@property(nonatomic, assign)UIEdgeInsets contentInsets;
@property(nonatomic, assign)CGFloat contentSize;
@property(nonatomic, assign)FMTransitionTranslateType type;
@property(nonatomic, assign)NSTimeInterval animationDuration;
@property(nonatomic, assign)NSTimeInterval animationDelay;
@property(nonatomic, assign)UIViewAnimationOptions animationOptions;
@property(nonatomic, assign)CGFloat animationDamping;
@property(nonatomic, assign)CGFloat animationVelocity;
@property(nonatomic, assign)CGFloat damingColorAlpha;
@property(nonatomic, assign)CGFloat damingTapCanDismiss;

+ (instancetype)defaultConfig;

@end

@interface FMFloatContainerController : UIViewController

@property(nonatomic, weak)UIView *containerView;
@property(nonatomic, weak)UIViewController *contentViewController;
@property(nonatomic, copy)void(^showCompletion)(void);
@property(nonatomic, copy)void(^hideCompletion)(void);

+ (void)showWithInViewController:(UIViewController *)viewController contentViewController:(UIViewController *)contentViewController contentSize:(CGFloat)size contentInset:(UIEdgeInsets)contentInset completion:(void (^)(void))completion;

+ (void)showWithInViewController:(UIViewController *)viewController contentViewController:(UIViewController *)contentViewController config:(FMFloatShowConfig *)config completion:(void (^)(void))completion;

- (void)dismissWithCompletion:(void (^)(void))completion;

@end

@interface UIViewController (FMFloat)

- (FMFloatContainerController * __nullable)floatContainerController;

@end

NS_ASSUME_NONNULL_END
