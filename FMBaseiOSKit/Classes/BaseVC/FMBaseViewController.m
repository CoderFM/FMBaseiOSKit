
#import "FMBaseViewController.h"
#import <Masonry/Masonry.h>
#import "FMConfig.h"

@interface FMBaseViewController ()
@property(nonatomic, assign)NSInteger loadEndCount;
@end

@implementation FMBaseViewController

- (void)dealloc{
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (UIView *)navContainer{
    if (_navContainer == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imageV = [[UIImageView alloc] init];
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _navBgImageView = imageV;
        [self.view addSubview:view];
        _navContainer = view;
    }
    return _navContainer;
}

- (UIView *)navBarContainer{
    if (_navBarContainer == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self.navContainer addSubview:view];
        _navBarContainer = view;
    }
    return _navBarContainer;
}

- (UINavigationBar *)navBar{
    if (_navBar == nil) {
        UINavigationBar *navBar = [[UINavigationBar alloc] init];
        [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:[UIImage new]];
        [self.navBarContainer addSubview:navBar];
        [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
        _navBar = navBar;
    }
    return _navBar;
}

- (UIView *)mainContainer{
    if (_mainContainer == nil) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        _mainContainer = view;
    }
    return _mainContainer;
}

- (UIView *)loadContainer{
    if (_loadContainer == nil) {
        UIView *view = [[UIView alloc] init];
        view.hidden = YES;
        [self.view addSubview:view];
        _loadContainer = view;
    }
    return _loadContainer;
}

- (UIView *)toolContainer{
    if (_toolContainer == nil) {
        UIView *view = [[UIView alloc] init];
        view.hidden = YES;
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        _toolContainer = view;
    }
    return _toolContainer;
}

- (UIView *)toolBarContainer{
    if (_toolBarContainer == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self.toolContainer addSubview:view];
        _toolBarContainer = view;
    }
    return _toolBarContainer;
}

- (UINavigationItem *)baseNavItem{
    if (_baseNavItem == nil) {
        _baseNavItem = [[UINavigationItem alloc] init];
    }
    return _baseNavItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.mainContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo([FMConfig config].navStatusHeight);
        make.bottom.mas_equalTo(0);
    }];
    [self.loadContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.mainContainer);
    }];
    
    [self.navContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo([FMConfig config].navStatusHeight);
    }];
    [self.navBarContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo([FMConfig config].navHeight);
    }];
    [self.toolContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo([FMConfig config].tabBarHeight);
    }];
    [self.toolBarContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo([FMConfig config].tabBarHeight - [FMConfig config].safeBottomHeight);
    }];
    self.needLoadNetCount = 1;
    ![FMConfig config].configurationBaseVC?nil:[FMConfig config].configurationBaseVC(self);
    [self.navBar pushNavigationItem:self.baseNavItem animated:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.didAppear) {
        !self.didAppearBlock?:self.didAppearBlock();
    }
    self.didAppear = YES;
}

- (void)baseBackClick{
    if (self.navigationController.viewControllers.count == 1) {
        if (self.navigationController.presentingViewController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)netLoadDataStart{
    if (self.loadEndCount < self.needLoadNetCount) {
        self.loadContainer.hidden = NO;
    }
}
- (void)netLoadDataEnd{
    self.loadEndCount += 1;
    if (self.loadEndCount >= self.needLoadNetCount) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.loadContainer.hidden = YES;
        });
    }
}

@end
