//
//  FMBaseSheetTableView.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/17.
//

#import "FMBaseSheetTableView.h"
#import "UITableView+FMExtension.h"
#import "FMBaseTableView.h"
#import "FMConfig.h"
#import <Masonry/Masonry.h>
#import "UIColor+FMExtension.h"

@implementation FMBaseSheetTableView

- (Class)cellClass{
    return [UITableViewCell class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        FMBaseTableView *tableView = [[FMBaseTableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:self.cellClass forCellReuseIdentifier:NSStringFromClass(self.cellClass)];
        tableView.showEmptyView = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.contentView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(56);
        }];
        self.tableView = tableView;
        
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(tableView.mas_top);
            make.height.mas_equalTo(1);
        }];

    }
    return self;
}

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellClass)];
    [self configurationCell:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


@end
