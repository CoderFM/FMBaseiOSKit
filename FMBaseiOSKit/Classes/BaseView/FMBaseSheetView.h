
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

@interface FMBaseSheetView : FMBasePopupView
@property(nonatomic, assign)FMSheetType type;
@property(nonatomic, assign, readonly)CGSize contentViewSize;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UIButton *closeBtn;
- (void)closeClick;


@end

NS_ASSUME_NONNULL_END
