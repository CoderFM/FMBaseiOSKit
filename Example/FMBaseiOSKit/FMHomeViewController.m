//
//  FMHomeViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/16.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMHomeViewController.h"
#import "FMLayoutViewController.h"

@interface FMHomeViewController ()

@end

@implementation FMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"首页";
    self.pageNavView.canScroll = YES;
    self.pageNavView.itemMargin = 30;
    self.pageNavView.titles = @[@"标签1", @"标签1", @"标签1", @"标签1", @"标签1", @"标签1", @"标签1", @"标签1"];
    NSMutableArray *arrM = [NSMutableArray array];
    {
        UIView *view0 = [UIView viewWithBackgroundColor:[UIColor randomColor]];
        [arrM addObject:view0];
    }
    {
        FMLayoutViewController *vc1 = [[FMLayoutViewController alloc] init];
        vc1.notHasNavView = YES;
        [arrM addObject:vc1];
    }
    {
        UIView *view0 = [UIView viewWithBackgroundColor:[UIColor randomColor]];
        [arrM addObject:view0];
    }
    {
        FMLayoutViewController *vc1 = [[FMLayoutViewController alloc] init];
        vc1.notHasNavView = YES;
        [arrM addObject:vc1];
    }
    {
        UIView *view0 = [UIView viewWithBackgroundColor:[UIColor randomColor]];
        [arrM addObject:view0];
    }
    {
        FMLayoutViewController *vc1 = [[FMLayoutViewController alloc] init];
        vc1.notHasNavView = YES;
        [arrM addObject:vc1];
    }
    {
        UIView *view0 = [UIView viewWithBackgroundColor:[UIColor randomColor]];
        [arrM addObject:view0];
    }
    {
        FMLayoutViewController *vc1 = [[FMLayoutViewController alloc] init];
        vc1.notHasNavView = YES;
        [arrM addObject:vc1];
    }
    [self createSubPages:arrM];
}

@end
