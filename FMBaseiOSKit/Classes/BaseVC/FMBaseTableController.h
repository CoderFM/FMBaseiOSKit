

#import "FMBaseListController.h"
#import "UITableView+FMExtension.h"
#import "FMBaseTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FMBaseTableController : FMBaseListController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, assign, readonly)UITableViewStyle tableStyle;
@property(nonatomic, weak)FMBaseTableView *tableView;
- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
