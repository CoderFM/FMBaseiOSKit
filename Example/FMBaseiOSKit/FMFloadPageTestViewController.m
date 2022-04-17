//
//  FMFloadPageTestViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/5/23.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import "FMFloadPageTestViewController.h"
#import <FMDataPublisher.h>
#import <FMBaseiOSKit/FMBaseiOSKit.h>

@interface FMFloadPageTestViewController ()

@property(nonatomic, strong)FMPresentAnimationDelegate *animationDelegate;

@end

@implementation FMFloadPageTestViewController

- (FMPresentAnimationDelegate *)animationDelegate{
    if (_animationDelegate == nil) {
        _animationDelegate = [[FMPresentAnimationDelegate alloc] init];
    }
    return _animationDelegate;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.animationDelegate;
    }
    return self;
}

- (void)dealloc{
    NSLog(@"FMFloadPageTestViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    UIButton *close = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    close.center = self.view.center;
    
    {
        FMDataPublisher *pub = [[FMDataPublisher alloc] init];
        pub.lifeCircle(self);
        [pub addObserve:^(id  _Nonnull data) {
            NSLog(@"%@", data);
        }];
        [pub publish:@"22222222"];
    }
    {
        FMDataPublisher *pub = [[FMDataPublisher alloc] init];
        pub.lifeCircle(self);
        [pub addObserve:^(id  _Nonnull data) {
            NSLog(@"%@", data);
        }];
        [pub publish:@"3333333"];
    }
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
