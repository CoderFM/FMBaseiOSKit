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

@property(nonatomic, strong)NSMutableArray *pages;

@end

@implementation FMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"首页";
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"重新创建" style:UIBarButtonItemStylePlain target:self action:@selector(reCreatePages)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"滚动到3" style:UIBarButtonItemStylePlain target:self action:@selector(scrollPagePages)];
    self.baseNavItem.rightBarButtonItems = @[item2, item1];
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
    self.pages = arrM;
    [self createSubPages:arrM];
}

- (void)reCreatePages{
    [self.pages exchangeObjectAtIndex:0 withObjectAtIndex:1];
    [self.pages exchangeObjectAtIndex:2 withObjectAtIndex:3];
    [self.pages exchangeObjectAtIndex:4 withObjectAtIndex:5];
    [self.pages exchangeObjectAtIndex:6 withObjectAtIndex:7];
    [self createSubPages:self.pages];
}

- (void)scrollPagePages{
    self.currentIndex = 3;
}

@end
