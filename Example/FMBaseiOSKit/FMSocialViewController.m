//
//  FMSocialViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/8/28.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMSocialViewController.h"

@interface FMSocialViewController ()

@property(nonatomic, strong)FMSocialTextTool *tool;

@property(nonatomic, weak)UITextField *tf;

@end

@implementation FMSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"发布";
    self.baseNavItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"获取" style:UIBarButtonItemStyleDone target:self action:@selector(getParam)];
    self.hasToolView = YES;
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    textView.font = [UIFont systemFontOfSize:15];
    [self.mainContainer addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.tool = [FMSocialTextTool createBindTextView:textView];
    
    {
        UIButton *btn = [UIButton buttonWithTitle:@"@" font:[UIFont systemFontOfSize:15] color:[UIColor orangeColor]];
        [self.toolBarContainer addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(btn.mas_height);
        }];
        [btn addTarget:self action:@selector(insertMember) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [UIButton buttonWithTitle:@"#" font:[UIFont systemFontOfSize:15] color:[UIColor orangeColor]];
        [self.toolBarContainer addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(btn.mas_height);
        }];
        [btn addTarget:self action:@selector(insertTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UITextField *tf = [[UITextField alloc] init];
        tf.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        tf.placeholder = @"请输入插入内容";
        [self.toolBarContainer addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(40);
        }];
        self.tf = tf;
    }
    
}

- (void)insertMember{
    [self.tool insertText:[NSString stringWithFormat:@"@%@", self.tf.text] bindObj:@"关注" color:nil];
}

- (void)insertTopic{
    [self.tool insertText:[NSString stringWithFormat:@"#%@#", self.tf.text] bindObj:@"话题" color:[UIColor purpleColor]];
}

- (void)getParam{
    
}

@end
