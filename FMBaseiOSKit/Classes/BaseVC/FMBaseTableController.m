

#import "FMBaseTableController.h"
#import <Masonry/Masonry.h>
#import "FMConfig.h"

@interface FMBaseTableController ()

@end

@implementation FMBaseTableController

- (FMBaseTableView *)tableView{
    if (_tableView == nil) {
        FMBaseTableView *tableView = [[FMBaseTableView alloc] initWithFrame:CGRectZero style:self.tableStyle];
        [tableView registerClass:self.cellClass forCellReuseIdentifier:NSStringFromClass(self.cellClass)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [UIView new];
        [self.mainContainer addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@(0));
        }];
        if(@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView = tableView;
    }
    return _tableView;
}

- (Class)cellClass{
    return [UITableViewCell class];
}

- (UIScrollView *)listView{
    return self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ![FMConfig config].configurationTableVC?nil:[FMConfig config].configurationTableVC(self);
}

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellClass)];
    [self configurationCell:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

@end
