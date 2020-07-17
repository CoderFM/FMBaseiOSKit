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

#import "UIView+FMExtension.h"

@interface FMPagesViewController ()

@property(nonatomic, strong)NSArray *pages;

@end

@implementation FMPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPageBtns];
    [self createPagesSupview];
}

- (void)createPageBtns{
    FMNavBtnsView *btns = [[FMNavBtnsView alloc] init];
    btns.lineAnimation = FMNavBtnsLineAnimationProgress;
    btns.lineBottomMargin = 3;
    FMWeakSelf;
    [btns setClickBlock:^(NSInteger tag) {
        [weakSelf.scrollView setContentOffset:CGPointMake([FMConfig config].screenWidth * tag, 0) animated:YES];
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
    self.scrollView.contentSize = CGSizeMake([FMConfig config].screenWidth * pages.count, 0);
    self.pages = pages;
    for (int i = 0; i<pages.count; i++) {
        id page = pages[i];
        if ([page isKindOfClass:[UIViewController class]]) {///控制器
            [self addChildViewController:page];
        } else if ([page isKindOfClass:[UIView class]]) {///view
            UIView *pageView = (UIView *)page;
            [self.scrollView addSubview:pageView];
            [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo([FMConfig config].screenWidth * i);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo([FMConfig config].screenWidth);
                make.height.mas_equalTo(self.scrollView);
            }];
        }
    }
    [self scrollToCurrentPage];
}

- (void)scrollToCurrentPage{
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    if (page < self.pages.count) {
        id pageV = self.pages[page];
        if ([pageV isKindOfClass:[UIViewController class]]) {
            UIViewController *pageVC = (UIViewController *)pageV;
            if (!pageVC.viewLoaded) {
                [self.scrollView addSubview:pageVC.view];
                [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo([FMConfig config].screenWidth * page);
                    make.top.mas_equalTo(0);
                    make.width.mas_equalTo([FMConfig config].screenWidth);
                    make.height.mas_equalTo(self.scrollView);
                }];
            }
        }
    }
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
