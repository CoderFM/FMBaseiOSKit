//
//  FormListSubmitVC.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FMFormListSubmitVC.h"
#import "FormListTextCell.h"
#import "FormListTextVCell.h"
#import "FormListImageUpCell.h"
#import "FormListSelectCell.h"
@interface FMFormListSubmitVC ()

@end

@implementation FMFormListSubmitVC

- (UITableViewStyle)tableStyle{
    return UITableViewStylePlain;
}

- (NSMutableArray *)dataSource
{
    return self.tableView.handle.models;
}

- (void)setDataSource:(NSMutableArray<FormListBaseModel *> *)dataSource{
    self.tableView.handle.models = dataSource;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        FormListSubmitView *table = [[FormListSubmitView alloc] initWithFrame:CGRectZero style:self.tableStyle];
        [table registerClass:[FormListTitleCell class] forCellReuseIdentifier:NSStringFromClass([FormListTitleCell class])];
        [self.mainContainer addSubview:table];
        if(@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView = table;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.needLoadNetCount = 0;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    [self configurationTable];
    
    [self addData];
}

- (void)addData{
    
}

- (void)configurationTable{
    
}

- (BOOL)verifyDataSource{
    return [self.tableView.handle verifyDataSource];
}
- (BOOL)verifyDataSource:(BOOL)alert{
    return [self.tableView.handle verifyDataSource:alert];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
@end
