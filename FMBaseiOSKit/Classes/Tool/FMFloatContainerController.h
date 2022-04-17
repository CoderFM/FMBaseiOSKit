//
//  FMFloatContainerController.h
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2022/4/16.
//  Copyright © 2022 zhoufaming251@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMFloatContainerController : UIViewController

@property(nonatomic, weak)UIView *containerView;
@property(nonatomic, weak)UIViewController *contentViewController;

+ (void)showWithInViewController:(UIViewController *)viewController contentViewController:(UIViewController *)contentViewController contentSize:(CGFloat)size contentInset:(UIEdgeInsets)contentInset completion:(void (^)(void))completion;

- (void)dismissWithCompletion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
