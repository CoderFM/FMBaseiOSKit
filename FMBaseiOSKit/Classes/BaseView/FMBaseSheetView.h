
#import "FMBasePopupView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FMSheetType) {
    /// 从下往上
    FMSheetTypeBottom,
    /// 总左往右
    FMSheetTypeLeft,
    /// 从右往左
    FMSheetTypeRight,
    /// 从上往下
    FMSheetTypeTop,
};

@interface FMBaseSheetView : FMBasePopupView<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, assign)FMSheetType type;
@property(nonatomic, assign, readonly)CGSize contentViewSize;
@property(nonatomic, assign, readonly)Class cellClass;
@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UIButton *closeBtn;
- (void)closeClick;

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
