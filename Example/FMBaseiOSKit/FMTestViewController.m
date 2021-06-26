//
//  FMTestViewController.m
//  FMBaseKit_Example
//
//  Created by 郑桂华 on 2020/5/29.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMTestViewController.h"

@interface FMTestViewController ()

@end

@implementation FMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor randomColor];
    NSLog(@"%@", self.navigationController.navigationBar);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
//    self.baseNavItem.title = @"测试控制器";
    
//    self.toolContainer.backgroundColor = [UIColor randomColor];
//    self.toolBarContainer.backgroundColor = [UIColor randomColor];
//    self.navContainer.backgroundColor = [UIColor randomColor];
//    self.navBarContainer.backgroundColor = [UIColor randomColor];
//    self.mainContainer.backgroundColor = [UIColor randomColor];
    // Do any additional setup after loading the view.
}

- (void)next{
    FMTestViewController *test = [[FMTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isBack) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
//    FMTestViewController *vc = [[FMTestViewController alloc] init];
//    vc.modalPresentationStyle = 0;
//    vc.isBack = YES;
//    [self presentViewController:vc animated:YES completion:nil];
}
@end
