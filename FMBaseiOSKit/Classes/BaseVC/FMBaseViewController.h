

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseViewController : UIViewController

@property(nonatomic, weak)Class loadContainerClass;

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
/// 系统的导航栏尺寸
@property(nonatomic, assign)CGRect originNavigationBarFrame;
/// 是否显示自定义的导航栏  默认为yes
@property(nonatomic, assign, readonly)BOOL showCustomNavigationBar;
/// 是否是全屏
@property(nonatomic, assign)BOOL isFullScreen;

@property(nonatomic, copy)void(^didAppearBlock)(void);
@property(nonatomic, assign)BOOL didAppear;

- (void)baseBackClick;
- (void)netLoadDataStart;
- (void)netLoadDataEnd;
@end

NS_ASSUME_NONNULL_END
