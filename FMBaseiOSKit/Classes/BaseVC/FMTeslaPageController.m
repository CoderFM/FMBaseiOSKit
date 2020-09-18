//
//  FMTeslaPageController.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/7.
//

#import "FMTeslaPageController.h"

@interface FMTeslaPageController ()

@end

@implementation FMTeslaPageController

- (NSMutableArray<FMTeslaPageModel *> *)pages{
    if (_pages == nil) {
        _pages = [NSMutableArray array];
    }
    return _pages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfScreenInTesla:(FMTeslaLayoutView *)tesla{
    return self.pages.count;
}

- (UIScrollView *)tesla:(FMTeslaLayoutView *)tesla customCreateWithIndex:(NSInteger)index shareHeight:(CGFloat)shareHeight{
    if (index < self.pages.count) {
        FMTeslaPageModel *model = self.pages[index];
        return [model customCreateScrollViewWithShareHeight:shareHeight];
    } else {
        return nil;
    }
}

- (void)tesla:(FMTeslaLayoutView *)tesla didCreatedScrollViewWithIndex:(NSInteger)index scrollView:(UIScrollView *)scrollView{
    if (index < self.pages.count) {
        FMTeslaPageModel *model = self.pages[index];
        [model didCreateScrollView:scrollView];
    }
}

- (void)tesla:(FMTeslaLayoutView *)tesla didScrollEnd:(NSInteger)index currentScrollView:(UIScrollView *)scrollView{
    if (index < self.pages.count) {
        FMTeslaPageModel *model = self.pages[index];
        [model didShow];
    }
}

@end
