

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseViewController : UIViewController

/// 需要请求几个接口再隐藏加载中  前提要是调用netLoadDataStart, netLoadDataEnd
@property(nonatomic, assign)NSInteger needLoadNetCount;

@property(nonatomic, assign)BOOL notHasNavView;
@property(nonatomic, assign)BOOL hasToolView;

@property(nonatomic, weak)UIView *navContainer;
@property(nonatomic, weak)UIView *navBarContainer;
@property(nonatomic, weak)UIImageView *navBgImageView;
@property(nonatomic, weak)UINavigationBar *navBar;
@property(nonatomic, weak)UIView *mainContainer;
@property(nonatomic, weak)UIView *loadContainer;
@property(nonatomic, weak)UIView *toolContainer;
@property(nonatomic, weak)UIView *toolBarContainer;

@property(nonatomic, strong)UINavigationItem *baseNavItem;

@property(nonatomic, copy)void(^didAppearBlock)(void);
@property(nonatomic, assign)BOOL didAppear;

- (void)baseBackClick;
- (void)netLoadDataStart;
- (void)netLoadDataEnd;
@end

NS_ASSUME_NONNULL_END
