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

@implementation FMFloatShowConfig

+ (instancetype)defaultConfig{
    FMFloatShowConfig *config = [[self alloc] init];
    config.contentInsets = UIEdgeInsetsZero;
    config.contentSize = 100;
    config.type = FMTransitionTranslateBTT;
    config.animationDuration = 0.25;
    config.animationOptions = UIViewAnimationCurveLinear;
    config.animationDelay = 0;
    config.animationDamping = 1;
    config.animationVelocity = 0;
    config.damingColorAlpha = 0.5;
    config.damingTapCanDismiss = YES;
    return config;
}

@end

@interface FMFloatContainerController ()

@property(nonatomic, strong)FMPresentAnimationDelegate *animationDelegate;

@property(nonatomic, strong)FMFloatShowConfig *config;
@property(nonatomic, assign)CGAffineTransform transform;

@end

@implementation FMFloatContainerController

+ (void)showWithInViewController:(UIViewController *)viewController contentViewController:(UIViewController *)contentViewController contentSize:(CGFloat)size contentInset:(UIEdgeInsets)contentInset completion:(void (^)(void))completion{
    FMFloatShowConfig *config = [FMFloatShowConfig defaultConfig];
    config.contentSize = size;
    config.contentInsets = contentInset;
    [self showWithInViewController:viewController contentViewController:contentViewController config:config completion:completion];
}

+ (void)showWithInViewController:(UIViewController *)viewController contentViewController:(UIViewController *)contentViewController config:(FMFloatShowConfig *)config completion:(void (^)(void))completion{
    FMFloatContainerController *containerVC = [[FMFloatContainerController alloc] init];
    containerVC.config = config;
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
    containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:containerView];
    switch (self.config.type) {
        case FMTransitionTranslateBTT:
        {
            [NSLayoutConstraint activateConstraints:@[
                [containerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:self.config.contentInsets.left],
                [containerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-self.config.contentInsets.right],
                [containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-self.config.contentInsets.bottom],
                [containerView.heightAnchor constraintEqualToConstant:self.config.contentSize]
            ]];
            self.transform = CGAffineTransformMakeTranslation(0, self.config.contentSize + self.config.contentInsets.bottom);
        }
            break;
        case FMTransitionTranslateTTB:
        {
            [NSLayoutConstraint activateConstraints:@[
                [containerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:self.config.contentInsets.left],
                [containerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-self.config.contentInsets.right],
                [containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.config.contentInsets.top],
                [containerView.heightAnchor constraintEqualToConstant:self.config.contentSize]
            ]];
            self.transform = CGAffineTransformMakeTranslation(0, -(self.config.contentSize + self.config.contentInsets.top));
        }
            break;
        case FMTransitionTranslateLTR:
        {
            [NSLayoutConstraint activateConstraints:@[
                [containerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:self.config.contentInsets.left],
                [containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.config.contentInsets.top],
                [containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-self.config.contentInsets.bottom],
                [containerView.widthAnchor constraintEqualToConstant:self.config.contentSize]
            ]];
            self.transform = CGAffineTransformMakeTranslation(-(self.config.contentSize + self.config.contentInsets.left), 0);
        }
            break;
        case FMTransitionTranslateRTL:
        {
            [NSLayoutConstraint activateConstraints:@[
                [containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.config.contentInsets.top],
                [containerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-self.config.contentInsets.right],
                [containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-self.config.contentInsets.bottom],
                [containerView.heightAnchor constraintEqualToConstant:self.config.contentSize]
            ]];
            self.transform = CGAffineTransformMakeTranslation((self.config.contentSize + self.config.contentInsets.right), 0);
        }
            break;
        default:
            break;
    }
    containerView.transform = self.transform;
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
    [UIView animateWithDuration:self.config.animationDuration delay:self.config.animationDelay usingSpringWithDamping:self.config.animationDamping initialSpringVelocity:self.config.animationVelocity options:self.config.animationOptions animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:self.config.damingColorAlpha];
        self.containerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        !self.showCompletion?:self.showCompletion();
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.config.damingTapCanDismiss) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        if (!CGRectContainsPoint(self.containerView.frame, point)) {
            [self dismissWithCompletion:^{
                
            }];
        }
    }
}

- (void)dismissWithCompletion:(void (^)(void))completion{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.containerView.transform = self.transform;
    } completion:^(BOOL finished) {
        !self.hideCompletion?:self.hideCompletion();
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}

@end

@implementation UIViewController (FMFloat)

- (FMFloatContainerController *)floatContainerController{
    if ([self.parentViewController isKindOfClass:[FMFloatContainerController class]]) {
        return (FMFloatContainerController *)self.parentViewController;
    }
    return nil;
}

@end
