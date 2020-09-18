//
//  FMTeslaViewController.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/14.
//

#import "FMTeslaViewController.h"
#import <Masonry/Masonry.h>
#import "FMNavBtnsView.h"
#import "FMConfig.h"

@interface FMTeslaViewController ()

@end

@implementation FMTeslaViewController

- (BOOL)isLoadSubview{
    return [[self.teslaView valueForKey:@"isLoadSubView"] boolValue];
}

- (FMTeslaLayoutView *)teslaView{
    if (_teslaView == nil) {
        FMTeslaLayoutView *tesla = [[FMTeslaLayoutView alloc] init];
        tesla.delegate = self;
        tesla.dataSource = self;
        [self.mainContainer addSubview:tesla];
        _teslaView = tesla;
    }
    return _teslaView;
}

- (void)setPageNavView:(FMNavBtnsView *)pageNavView{
    _pageNavView = pageNavView;
    FMWeakSelf;
    [pageNavView setClickBlock:^(NSInteger tag) {
        [weakSelf.teslaView scrollToIndex:tag animated:NO];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.teslaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.pageSections = [NSMutableArray array];
}

- (NSArray<FMLayoutBaseSection *> *)shareSectionsInTesla:(FMTeslaLayoutView *)tesla{
    return self.shareSections;
}

- (NSInteger)numberOfScreenInTesla:(FMTeslaLayoutView *)tesla{
    return self.pageSections.count;
}

- (void)tesla:(FMTeslaLayoutView *)tesla scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.pageNavView.lineAnimation == FMNavBtnsLineAnimationProgress) {
        CGFloat progress = (scrollView.contentOffset.x - self.pageNavView.selected * scrollView.frame.size.width) / scrollView.frame.size.width;
        if (scrollView.contentOffset.x < self.pageNavView.selected * scrollView.frame.size.width) {
            [self.pageNavView scrollPrevProgress:progress];
        } else if (scrollView.contentOffset.x > self.pageNavView.selected * scrollView.frame.size.width) {
            [self.pageNavView scrollNextProgress:progress];
        }
    }
}

- (void)tesla:(FMTeslaLayoutView *)tesla didCreatedScrollViewWithIndex:(NSInteger)index scrollView:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[FMLayoutView class]] && index < self.pageSections.count) {
        ((FMLayoutView *)scrollView).sections = self.pageSections[index];
    }
}

- (void)tesla:(FMTeslaLayoutView *)tesla currentShowScrollView:(UIScrollView *)scrollView index:(NSInteger)index{
    self.pageNavView.selected = index;
}

@end
