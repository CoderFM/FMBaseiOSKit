//
//  FMFloatContainerController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2022/4/16.
//  Copyright © 2022 zhoufaming251@163.com. All rights reserved.
//

#import "FMFloatContainerController.h"
#import "FMPresentAnimationDelegate.h"
#import "FMTransitionAnimatorFactory.h"

@interface FMFloatContainerController ()

@property(nonatomic, strong)FMPresentAnimationDelegate *animationDelegate;
@property(nonatomic, assign)CGFloat size;
@property(nonatomic, assign)UIEdgeInsets contentInset;
@property(nonatomic, copy)void(^showCompletion)(void);

@end

@implementation FMFloatContainerController

+ (void)showWithInViewController:(UIViewController *)viewController contentViewController:(UIViewController *)contentViewController contentSize:(CGFloat)size contentInset:(UIEdgeInsets)contentInset completion:(void (^)(void))completion{
    FMFloatContainerController *containerVC = [[FMFloatContainerController alloc] init];
    containerVC.size = size;
    containerVC.contentInset = contentInset;
    containerVC.showCompletion = completion;
    containerVC.modalPresentationStyle = UIModalPresentationCustom;
    containerVC.transitioningDelegate = containerVC.animationDelegate;
    [containerVC addChildViewController:contentViewController];
    containerVC.contentViewController = contentViewController;
    [viewController presentViewController:containerVC animated:NO completion:nil];
}

- (FMPresentAnimationDelegate *)animationDelegate{
    if (_animationDelegate == nil) {
        _animationDelegate = [FMPresentAnimationDelegate delegateWithAnimator:[FMTransitionAnimatorFactory alphaAnimation]];
    }
    return _animationDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    [NSLayoutConstraint activateConstraints:@[
        [containerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:self.contentInset.left],
        [containerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-self.contentInset.right],
        [containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-self.contentInset.bottom],
        [containerView.heightAnchor constraintEqualToConstant:self.size]
    ]];
    containerView.transform = CGAffineTransformMakeTranslation(0, self.size + self.contentInset.bottom);
    self.containerView = containerView;
    
    [containerView addSubview:self.contentViewController.view];
    self.contentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.contentViewController.view.leftAnchor constraintEqualToAnchor:containerView.leftAnchor],
        [self.contentViewController.view.rightAnchor constraintEqualToAnchor:containerView.rightAnchor],
        [self.contentViewController.view.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [self.contentViewController.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor]
    ]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.containerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        !self.showCompletion?:self.showCompletion();
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissWithCompletion:^{
        
    }];
}

- (void)dismissWithCompletion:(void (^)(void))completion{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.containerView.transform = CGAffineTransformMakeTranslation(0, self.contentInset.bottom + self.size);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}

@end
