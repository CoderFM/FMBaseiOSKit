//
//  FMTestEmptyTableController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/20.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMTestEmptyTableController.h"

@interface FMTestEmptyView : UIView

@end

@implementation FMTestEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
    }
    return self;
}

@end

@interface FMTestEmptyTableController ()

@end

@implementation FMTestEmptyTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"列表空视图";
    self.baseNavItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(changeStyle)];
    self.tableView.nonDataViewClass = [FMTestEmptyView class];
    [self.tableView reloadData];
}

- (void)changeStyle{
    [[FMConfig config] setConfigurationNoneDataView:^(FMNoneDataView * _Nonnull noneData) {
        noneData.nonTextLabel.textColor = [UIColor blackColor];
        noneData.nonTextLabel.font = [UIFont systemFontOfSize:20];
        noneData.nonTextLabel.text = @"重新设置的暂无数据视图";
    }];
    self.tableView.nonDataViewClass = nil;
    [self.tableView reloadData];
}

@end
