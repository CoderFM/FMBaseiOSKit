//
//  FMPagesViewController.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/16.
//

#import "FMPagesViewController.h"
#import "FMNavBtnsView.h"
#import "FMConfig.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

#import "UIView+FMExtension.h"

@interface NSObject (FMPagesLoaded)

@property(nonatomic, assign)BOOL __isLayoutFinish;

@end

static void *__FMPagesLoadedKey = &__FMPagesLoadedKey;

@implementation NSObject (FMPagesLoaded)

- (BOOL)__isLayoutFinish{
    return [objc_getAssociatedObject(self, __FMPagesLoadedKey) boolValue];
}

- (void)set__isLayoutFinish:(BOOL)__isLayoutFinish{
    objc_setAssociatedObject(self, __FMPagesLoadedKey, @(__isLayoutFinish), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@interface FMPagesViewController ()

@property(nonatomic, strong)NSArray *__pages;

@end

@implementation FMPagesViewController

- (void)setCurrentIndex:(NSInteger)currentIndex{
    [self setCurrentIndex:currentIndex animated:NO];
}

- (void)setCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated{
    if (_currentIndex == currentIndex) {
        return;
    }
    _currentIndex = currentIndex;
    self.pageNavView.selected = currentIndex;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * currentIndex, 0) animated:animated];
    if (!animated) {
        [self scrollToCurrentPage];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPageBtns];
    [self createPagesSupview];
}

- (void)createPageBtns{
    FMNavBtnsView *btns = [[FMNavBtnsView alloc] init];
    btns.selected = self.currentIndex;
    btns.lineAnimation = FMNavBtnsLineAnimationProgress;
    btns.lineBottomMargin = 3;
    FMWeakSelf;
    [btns setClickBlock:^(NSInteger tag) {
        [weakSelf.scrollView setContentOffset:CGPointMake(weakSelf.scrollView.frame.size.width * tag, 0) animated:YES];
    }];
    [self.mainContainer addSubview:btns];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    self.pageNavView = btns;
}

- (void)createPagesSupview{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.mainContainer addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.pageNavView.mas_bottom);
    }];
    self.scrollView = scrollView;
}

- (void)createSubPages:(NSArray *)pages{
    [self.scrollView removeAllSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * pages.count, 0);
    self.__pages = pages;
    for (int i = 0; i<pages.count; i++) {
        NSObject *page = pages[i];
        if ([page isKindOfClass:[UIViewController class]]) {///控制器
            if (![self.childViewControllers containsObject:(UIViewController *)page]) {
                [self addChildViewController:(UIViewController *)page];
            }
            page.__isLayoutFinish = NO;
        } else if ([page isKindOfClass:[UIView class]]) {///view
            UIView *pageView = (UIView *)page;
            [self.scrollView addSubview:pageView];
            [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.scrollView.frame.size.width * i);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(self.scrollView.frame.size.width);
                make.height.mas_equalTo(self.scrollView);
            }];
            page.__isLayoutFinish = YES;
        }
    }
    [self scrollToCurrentPage];
}

- (void)scrollToCurrentPage{
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    if (page < self.__pages.count) {
        NSObject *pageV = self.__pages[page];
        UIView *pageView;
        if ([pageV isKindOfClass:[UIViewController class]]) {
            UIViewController *pageVC = (UIViewController *)pageV;
            pageView = pageVC.view;
        } else if ([pageV isKindOfClass:[UIView class]]) {
            pageView = (UIView *)pageV;
        }
        if (![self.scrollView.subviews containsObject:pageView]) {
            [self.scrollView addSubview:pageView];
        }
        if (!pageV.__isLayoutFinish) {
            [pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.scrollView.frame.size.width * page);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(self.scrollView.frame.size.width);
                make.height.mas_equalTo(self.scrollView);
            }];
            pageV.__isLayoutFinish = YES;
        }
    }
    _currentIndex = page;
    if (self.pageNavView.selected != page) {
        self.pageNavView.selected = page;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat progress = (scrollView.contentOffset.x - self.pageNavView.selected * scrollView.frame.size.width) / scrollView.frame.size.width;
    if (scrollView.contentOffset.x < self.pageNavView.selected * scrollView.frame.size.width) {
        [self.pageNavView scrollPrevProgress:progress];
    } else if (scrollView.contentOffset.x > self.pageNavView.selected * scrollView.frame.size.width) {
        [self.pageNavView scrollNextProgress:progress];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollToCurrentPage];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self scrollToCurrentPage];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollToCurrentPage];
}

@end
