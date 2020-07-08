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
    self.mainContainer.backgroundColor = [UIColor randomColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isBack) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    FMTestViewController *vc = [[FMTestViewController alloc] init];
    vc.modalPresentationStyle = 0;
    vc.isBack = YES;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
