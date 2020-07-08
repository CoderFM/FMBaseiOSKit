

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseListController : FMBaseViewController
@property(nonatomic, assign)NSInteger currentPage;// 分页
@property(nonatomic, assign, readonly)Class cellClass;// cell类
@property(nonatomic, weak, readonly)UIScrollView *listView;// 滚动视图
@property(nonatomic, strong)NSMutableArray *models; // model数组
@property(nonatomic, assign)BOOL hasFooter;
@property(nonatomic, assign)BOOL hasHeader;
- (void)headerRefresh; // 顶部刷新
- (void)footerRefresh; // 底部加载
- (void)loadListData;
@end

NS_ASSUME_NONNULL_END
