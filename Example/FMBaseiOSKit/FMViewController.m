//
//  FMViewController.m
//  FMBaseKit
//
//  Created by zhoufaming251@163.com on 05/16/2020.
//  Copyright (c) 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMViewController.h"
#import <FMBaseiOSKit/FMBaseiOSKit.h>
#import "FMTestViewController.h"

#import "FMLayoutViewController.h"
#import "FMFormViewController.h"

#import <Masonry/Masonry.h>

@interface FMViewController ()

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    {
        FMNavBtnsView *nav1 = [[FMNavBtnsView alloc] init];
        nav1.titles = @[@"标签1", @"标签1", @"标签1", @"标签1", @"标签1"];
        [self.view addSubview:nav1];
        [nav1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
    }
    {
        FMNavBtnsView *nav1 = [[FMNavBtnsView alloc] init];
        nav1.canScroll = YES;
        nav1.itemMargin = 40;
        nav1.titles = @[@"标签1", @"标签标签11", @"标", @"标签1标签标签11", @"标签221", @"标签1asdasdadasd", @"标222签1", @"标s签1", @"标223434签1", @"标签1", @"标签标签11"];
        [self.view addSubview:nav1];
        [nav1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(140);
            make.height.mas_equalTo(40);
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    FMTestViewController *vc = [[FMTestViewController alloc] init];
//    vc.modalPresentationStyle = 0;
////    [vc setDidAppearBlock:^{
////
////    }];
//    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)sheetClick:(id)sender {
    [FMBaseSheetView showToView:self.view.window];
}
- (IBAction)alertClick:(id)sender {
    [FMBaseAlertView showToView:self.view.window];
}

- (IBAction)layoutClick:(id)sender {
    FMLayoutViewController *vc = [[FMLayoutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)formClick:(id)sender {
    FMFormViewController *vc = [[FMFormViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
